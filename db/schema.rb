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

ActiveRecord::Schema[8.0].define(version: 2025_08_09_093856) do
  create_table "comments", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.text "content", null: false
    t.string "anonymous_name", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id", "created_at"], name: "index_comments_on_quote_id_and_created_at"
    t.index ["quote_id"], name: "index_comments_on_quote_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content", null: false
    t.string "quote_type", limit: 20, null: false
    t.integer "views_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "dislikes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_quotes_on_created_at"
    t.index ["quote_type"], name: "index_quotes_on_quote_type"
    t.index ["user_id", "created_at"], name: "index_quotes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "linkedin_url", limit: 500
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name"], name: "index_users_on_first_name_and_last_name"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.string "vote_type", limit: 10, null: false
    t.string "ip_address", limit: 45, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quote_id", "ip_address"], name: "index_votes_on_quote_id_and_ip_address", unique: true
    t.index ["quote_id"], name: "index_votes_on_quote_id"
    t.index ["vote_type"], name: "index_votes_on_vote_type"
  end

  add_foreign_key "comments", "quotes"
  add_foreign_key "quotes", "users"
  add_foreign_key "votes", "quotes"
end
