class Type < ApplicationRecord
    has_many :cards, through: :card_types

    validates :name, presence: :true, uniqueness: :true
end
