class Type < ApplicationRecord
    has_many :cards, through: :card_types, source: :card

    validates :name, presence: :true, uniqueness: :true
end
