class ManaCost < ApplicationRecord
  belongs_to :card
  belongs_to :mana

  validates :quantity, presence: true, numericality: { only_integer: true }

  before_save :ensure_valid_quantity

  def ensure_valid_quantity
    errors.add(:quantity, "Must be greater than or equal to 0") if quantity < 0
  end

end
