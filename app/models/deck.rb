class Deck < ApplicationRecord
  belongs_to :player
  has_many :deck_cards

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }

  before_save :ensure_valid_quantity

  private

  def ensure_valid_quantity
  errors.add(:quantity, "Must be greater than or equal to 0") if quantity < 0
  end
end
