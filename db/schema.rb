# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_07_24_235645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_result_stats", force: :cascade do |t|
    t.date "date", null: false
    t.string "subject", null: false
    t.float "daily_high", default: 0.0
    t.float "daily_low", default: 0.0
    t.float "total", default: 0.0
    t.integer "result_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_daily_result_stats_on_date"
  end

  create_table "monthly_averages", force: :cascade do |t|
    t.date "date", null: false
    t.string "subject", null: false
    t.float "monthly_avg_low", default: 0.0
    t.float "monthly_avg_high", default: 0.0
    t.integer "monthly_result_count_used", default: 0
    t.float "total", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_monthly_averages_on_date"
  end

  create_table "results", force: :cascade do |t|
    t.datetime "timestamp", null: false
    t.string "subject", null: false
    t.float "marks", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject"], name: "index_results_on_subject"
    t.index ["timestamp"], name: "index_results_on_timestamp"
  end

end
