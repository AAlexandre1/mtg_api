class Keyword < ApplicationRecord
    has_many :cards, through: :card_keywords

    validates :name, presence: :true, uniqueness: :true
end
