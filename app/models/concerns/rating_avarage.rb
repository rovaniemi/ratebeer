module Rating_avarage
  extend ActiveSupport::Concern
    def average_rating
        ratings.average(:score)
    end
end
