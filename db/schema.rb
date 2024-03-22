# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_09_073647) do
  create_table "card_types", id: false, force: :cascade do |t|
    t.integer "card_id"
    t.integer "type_id"
    t.index ["card_id"], name: "index_card_types_on_card_id"
    t.index ["type_id"], name: "index_card_types_on_type_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "set"
    t.integer "power"
    t.integer "toughness"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer "deck_id", null: false
    t.integer "card_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_deck_cards_on_card_id"
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.integer "player_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_decks_on_player_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "card_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_libraries_on_card_id"
    t.index ["player_id"], name: "index_libraries_on_player_id"
  end

  create_table "mana_costs", force: :cascade do |t|
    t.integer "card_id", null: false
    t.integer "mana_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_mana_costs_on_card_id"
    t.index ["mana_id"], name: "index_mana_costs_on_mana_id"
  end

  create_table "manas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "card_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_wishlists_on_card_id"
    t.index ["player_id"], name: "index_wishlists_on_player_id"
  end

  add_foreign_key "deck_cards", "cards"
  add_foreign_key "deck_cards", "decks"
  add_foreign_key "decks", "players"
  add_foreign_key "libraries", "cards"
  add_foreign_key "libraries", "players"
  add_foreign_key "mana_costs", "cards"
  add_foreign_key "mana_costs", "manas"
  add_foreign_key "wishlists", "cards"
  add_foreign_key "wishlists", "players"
end
