class CreateDecks < ActiveRecord::Migration[7.1]
  def change
    create_table :decks do |t|
      t.string :name
      t.references :player, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
