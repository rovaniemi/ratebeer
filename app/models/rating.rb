class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user
  @ratings = Rating.all
  
  def to_s
    "#{beer.name}: #{score}"
  end

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

end
