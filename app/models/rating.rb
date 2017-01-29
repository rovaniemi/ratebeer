class Rating < ActiveRecord::Base
  belongs_to :beer
  @ratings = Rating.all
  def to_s
    "#{beer.name}: #{score}"
  end
end
