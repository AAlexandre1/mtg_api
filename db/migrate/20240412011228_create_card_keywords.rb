class CreateCardKeywords < ActiveRecord::Migration[7.1]
  def change
    create_table :card_keywords do |t|
      t.references :card, null: false, foreign_key: true
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end
  end
end
