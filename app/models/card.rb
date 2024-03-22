class Card < ApplicationRecord
    has_many :types, through: :card_types
    has_many :libraries
    has_many :wishlists
    has_many :deck_cards
    has_many :mana_costs

    validates :name, presence: true, uniqueness: true
    validates :set, presence: true
    validates :power, presence: true, numericality: { only_integer: true }
    validates :toughness, presence: true, numericality: { only_integer: true }
    validates :description, presence: true

    accepts_nested_attributes_for :mana_costs

    before_save :ensure_valid_power
    before_save :ensure_valid_toughness

    private

    def ensure_valid_power
    errors.add(:power, "Must be greater than or equal to 0") if power < 0
    end
    def ensure_valid_toughness
    errors.add(:toughness, "Must be greater than or equal to 0") if toughness < 0
    end

end
