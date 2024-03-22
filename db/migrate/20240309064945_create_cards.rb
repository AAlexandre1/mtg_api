class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :set
      t.integer :power
      t.integer :toughness
      t.text :description

      t.timestamps
    end
  end
end
