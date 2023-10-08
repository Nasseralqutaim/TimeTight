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

ActiveRecord::Schema[7.1].define(version: 2023_10_08_205000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agenda_items", force: :cascade do |t|
    t.bigint "call_session_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["call_session_id"], name: "index_agenda_items_on_call_session_id"
  end

  create_table "call_sessions", force: :cascade do |t|
    t.bigint "initiator_id", null: false
    t.bigint "recipient_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initiator_id"], name: "index_call_sessions_on_initiator_id"
    t.index ["recipient_id"], name: "index_call_sessions_on_recipient_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "call_session_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["call_session_id"], name: "index_feedbacks_on_call_session_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "agenda_items", "call_sessions"
  add_foreign_key "call_sessions", "users", column: "initiator_id"
  add_foreign_key "call_sessions", "users", column: "recipient_id"
  add_foreign_key "feedbacks", "call_sessions"
end
