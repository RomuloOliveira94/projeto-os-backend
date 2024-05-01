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

ActiveRecord::Schema[7.1].define(version: 2024_05_01_234433) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "cnpj"
    t.string "address"
    t.string "neighborhood"
    t.string "phone"
    t.string "email"
    t.string "logo"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.integer "status", default: 0
    t.integer "business", default: 0
    t.string "payment_methods", default: [], array: true
    t.text "os_rules"
    t.text "budget_rules"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name"
    t.string "cpf_cnpj"
    t.string "email"
    t.string "phone"
    t.string "address"
    t.string "address_number"
    t.string "address_complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_customers_on_company_id"
  end

  create_table "service_orders", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.jsonb "products"
    t.jsonb "services"
    t.jsonb "other_fees"
    t.jsonb "materials"
    t.text "observations"
    t.float "subtotal"
    t.float "discount"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id", null: false
    t.index ["company_id"], name: "index_service_orders_on_company_id"
    t.index ["customer_id"], name: "index_service_orders_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "users"
  add_foreign_key "customers", "companies"
  add_foreign_key "service_orders", "companies"
  add_foreign_key "service_orders", "customers"
end
