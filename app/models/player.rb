class Player < ApplicationRecord
    has_many :libraries
    has_many :wishlists
    has_many :decks

    validates :username, presence: :true, uniqueness: :true
end
