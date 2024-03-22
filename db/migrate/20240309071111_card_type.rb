class CardType < ActiveRecord::Migration[7.1]
  def change
    create_table :card_types, id: false do |t|
      t.belongs_to :card
      t.belongs_to :type
    end
  end
end