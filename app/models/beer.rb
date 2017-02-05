class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :ratings, dependent: :destroy
    has_many :raters, through: :ratings, source: :user

    include Rating_average

    def to_s
        "#{brewery.name}: #{name}"
    end

    validates :name, presence: true
end
