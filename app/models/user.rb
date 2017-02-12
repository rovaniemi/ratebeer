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
    ratings.map { |a| a.beer.style }.uniq.sort_by { |b| style_average(b) }.last
  end

  def style_average (att)
    return nil if ratings.empty?
    all = ratings.find_all{|a| a.beer.style == att}.map{|a| a.score}
    (all.sum / all.count.to_f).round(2)
  end

  def favorite_brewery
    return ratings.map { |a| a.beer.brewery }.uniq.sort_by { |b| b.average_rating }.last
  end
end
