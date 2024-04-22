class CreateCardTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :card_types do |t|
      t.references :card, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
