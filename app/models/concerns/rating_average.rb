module Rating_average
  extend ActiveSupport::Concern
    def average_rating
        ratings.average(:score)
    end
end
