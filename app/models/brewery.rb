class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include Rating_average

  validates :year, numericality: { only_integer: true }
  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                   only_integer: true,
                                   less_than_or_equal_to: Date.today.year}
end
