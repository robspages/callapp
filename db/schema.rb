# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180908213033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "callers", force: :cascade do |t|
    t.text "name"
    t.text "original_title"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calls", force: :cascade do |t|
    t.bigint "callers_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["callers_id"], name: "index_calls_on_callers_id"
  end

  create_table "recordings", force: :cascade do |t|
    t.bigint "caller_id"
    t.datetime "call_date"
    t.string "recording_folder"
    t.boolean "copied_to_mp3", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "checksum"
    t.text "transcript"
    t.string "file_path"
    t.bigint "call_id"
    t.index ["call_id"], name: "index_recordings_on_call_id"
    t.index ["caller_id"], name: "index_recordings_on_caller_id"
    t.index ["checksum"], name: "index_recordings_on_checksum"
    t.index ["transcript"], name: "index_recordings_on_transcript"
  end

  add_foreign_key "calls", "callers", column: "callers_id"
  add_foreign_key "recordings", "callers"
  add_foreign_key "recordings", "calls"
end
