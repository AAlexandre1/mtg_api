class Card < ApplicationRecord
    has_many :card_types
    has_many :types, through: :card_types
    has_many :card_keywords
    has_many :keywords, through: :card_keywords
    has_many :libraries
    has_many :wishlists
    has_many :deck_cards
    has_many :mana_costs

    validates :name, presence: true, uniqueness: true
    validates :set, presence: true
    validates :power, allow_nil: true, numericality: { only_integer: true }
    validates :toughness, allow_nil: true, numericality: { only_integer: true }
    validates :description, presence: true

    accepts_nested_attributes_for :mana_costs

    before_save :ensure_valid_power
    before_save :ensure_valid_toughness

    private

    def ensure_valid_power
        if power.present? 
            errors.add(:power, "Must be greater than or equal to 0") if power < 0
        end
    end

    def ensure_valid_toughness
        if toughness.present?
            errors.add(:toughness, "Must be greater than or equal to 0") if toughness < 0
        end
    end

end
