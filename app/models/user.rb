class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { in: 3..30 }
  validate :at_least_one_upper
  validate :at_least_one_number


  include Rating_average

  has_secure_password

  def at_least_one_number
    if not /[0-9]/.match(password)
      errors.add(:password, "must contains at least one number")
    end
  end

  def at_least_one_upper
    if not /[A-Z]/.match(password)
      errors.add(:password, "must contains at least one upper character")
    end
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    return Beer.find_by_sql("
    SELECT beers.*, SUM(ratings.score) as sum
    FROM beers JOIN ratings ON beers.id = ratings.beer_id
    JOIN users ON ratings.user_id = users.id
    WHERE ratings.user_id = " + id.to_s + "
    GROUP BY beers.style ORDER BY sum DESC LIMIT 1").first.style
  end

  def favorite_brewery
    return nil if ratings.empty?
    return Beer.find_by_sql("
    SELECT beers.*,
    SUM(ratings.score) as sum
    FROM beers
    JOIN breweries ON breweries.id = beers.brewery_id
    JOIN users ON ratings.user_id = users.id
    JOIN ratings ON beers.id = ratings.beer_id
    WHERE ratings.user_id = " + id.to_s + "
    GROUP BY breweries.id ORDER BY sum DESC LIMIT 1").first.brewery.name
  end
end
