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

end
