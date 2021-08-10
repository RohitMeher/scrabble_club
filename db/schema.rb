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

ActiveRecord::Schema.define(version: 2021_08_09_183304) do

  create_table "addresses", charset: "utf8mb4", force: :cascade do |t|
    t.text "address1"
    t.text "address2"
    t.string "address3"
    t.string "post_code"
    t.string "phone_number"
    t.bigint "member_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_addresses_on_member_id"
  end

  create_table "matches", charset: "utf8mb4", force: :cascade do |t|
    t.date "start_date"
    t.text "venue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "members", charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "join_date"
    t.integer "matches_played", default: 0
    t.integer "wins", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_name"
  end

  create_table "participants", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "member_id"
    t.integer "score"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_participants_on_match_id"
    t.index ["member_id"], name: "index_participants_on_member_id"
  end

end
