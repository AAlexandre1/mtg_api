class DeckCard < ApplicationRecord
  belongs_to :deck
  belongs_to :card

  validates :deck_id, presence: true
  validates :card_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }

  before_save :ensure_valid_quantity

    private

    def ensure_valid_quantity
    errors.add(:quantity, "Must be greater than or equal to 0") if quantity < 0
    end
end
