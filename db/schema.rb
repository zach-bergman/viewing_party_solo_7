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

ActiveRecord::Schema[7.1].define(version: 2024_07_13_175008) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_parties", force: :cascade do |t|
    t.bigint "viewing_party_id", null: false
    t.bigint "user_id", null: false
    t.boolean "host"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_parties_on_user_id"
    t.index ["viewing_party_id"], name: "index_user_parties_on_viewing_party_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "viewing_parties", force: :cascade do |t|
    t.integer "duration"
    t.string "date"
    t.string "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "movie_id"
  end

  add_foreign_key "user_parties", "users"
  add_foreign_key "user_parties", "viewing_parties"
end
