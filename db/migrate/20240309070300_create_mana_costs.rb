class CreateManaCosts < ActiveRecord::Migration[7.1]
  def change
    create_table :mana_costs do |t|
      t.references :card, null: false, foreign_key: true
      t.references :mana, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
