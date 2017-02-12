module Rating_average
  extend ActiveSupport::Concern
    def average_rating
      return nil if ratings.empty?
      (ratings.map { |a| a.score }.sum / ratings.count.to_f).round(1)
    end
end
