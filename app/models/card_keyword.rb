class CardKeyword < ApplicationRecord
  belongs_to :card_id
  belongs_to :keyword_id
end
