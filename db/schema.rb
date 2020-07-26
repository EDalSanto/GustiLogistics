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

ActiveRecord::Schema.define(version: 20200726165245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.integer "sold"
    t.date "date"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purchased", default: 0
    t.index ["date"], name: "index_activities_on_date"
    t.index ["product_id", "date"], name: "index_activities_on_product_id_and_date", unique: true
    t.index ["product_id"], name: "index_activities_on_product_id"
  end

  create_table "activity_imports", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_purchase_orders", id: :serial, force: :cascade do |t|
    t.date "date"
    t.integer "quantity"
    t.integer "product_id"
    t.integer "customer_id"
    t.index ["customer_id", "date", "product_id"], name: "my_index", unique: true
    t.index ["customer_id"], name: "index_customer_purchase_orders_on_customer_id"
    t.index ["date", "product_id"], name: "index_customer_purchase_orders_on_date_and_product_id"
    t.index ["date"], name: "index_customer_purchase_orders_on_date"
    t.index ["product_id"], name: "index_customer_purchase_orders_on_product_id"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_customers_on_name", unique: true
  end

  create_table "product_snoozes", force: :cascade do |t|
    t.integer "product_id", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "end_date"], name: "index_product_snoozes_on_product_id_and_end_date"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "gusti_id"
    t.string "description"
    t.integer "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lead_time"
    t.integer "travel_time", default: 1
    t.integer "cover_time"
    t.string "growth_factor", default: "1.2"
    t.date "cant_travel_start"
    t.date "cant_travel_end"
    t.date "cant_produce_end"
    t.date "cant_produce_start"
    t.date "next_reorder_date"
    t.boolean "enroute", default: false
    t.index ["gusti_id"], name: "index_products_on_gusti_id", unique: true
  end

  create_table "purchase_imports", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", id: :serial, force: :cascade do |t|
    t.string "customer"
    t.string "item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reorders", id: :serial, force: :cascade do |t|
    t.date "date"
    t.integer "quantity"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reorders_on_product_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
