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

ActiveRecord::Schema.define(version: 20170619134253) do

  create_table "analytics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string "analytic_name"
    t.text "analytic", limit: 4294967295
    t.string "analytic_type"
    t.string "analytic_format"
    t.string "tlp", default: "Amber"
    t.integer "user_id"
    t.integer "version", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytic_name", "tlp", "updated_at"], name: "index_analytics_on_analytic_name_and_tlp_and_updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string "user_name"
    t.string "real_name"
    t.string "email_address"
    t.string "phone_number"
    t.string "password_digest"
    t.boolean "active", default: false
    t.string "remember_token"
    t.string "api_key"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_name", "email_address"], name: "index_users_on_user_name_and_email_address"
  end

end
