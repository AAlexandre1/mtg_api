class Deck < ApplicationRecord
  belongs_to :player
  has_many :deck_cards

  validates :name, presence: true
  validates :player_id, presence: true


end
