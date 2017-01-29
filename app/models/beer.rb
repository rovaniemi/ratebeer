class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    include Rating_avarage

    def to_s
        "#{brewery.name}: #{name}"
    end
end
