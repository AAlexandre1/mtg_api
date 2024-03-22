class CreateWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wishlists do |t|
      t.references :player, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
