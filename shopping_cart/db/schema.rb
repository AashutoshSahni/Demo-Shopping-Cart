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

ActiveRecord::Schema.define(version: 2021_04_14_095838) do

  create_table "cards", force: :cascade do |t|
    t.string "card_owner"
    t.string "card_number"
    t.string "expiry_date"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cvv"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.string "description"
    t.float "price"
    t.integer "quantity"
    t.string "file"
    t.integer "return_or_replacement_applicable_days"
    t.string "seller_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "available_quantity"
    t.integer "user_id"
    t.integer "product_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "ordered_items", force: :cascade do |t|
    t.string "description"
    t.float "price_per_item"
    t.integer "quantity"
    t.float "total_price"
    t.string "file"
    t.string "seller_name"
    t.integer "return_or_replacement_applicable_days"
    t.integer "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["order_id"], name: "index_ordered_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float "order_amount"
    t.float "shipping_charges"
    t.float "total_amount_paid"
    t.string "order_date"
    t.string "expected_delivery_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "pin_code"
    t.string "mobile_number"
    t.string "card_number"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "description"
    t.float "price"
    t.integer "return_or_replacement_applicable_days"
    t.string "category"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "file"
    t.string "seller_name"
    t.integer "available_quantity"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "shipping_details", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "mobile_number"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pin_code"
    t.string "city"
    t.string "state"
    t.index ["user_id"], name: "index_shipping_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cards", "users"
  add_foreign_key "ordered_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "users"
  add_foreign_key "shipping_details", "users"
end
