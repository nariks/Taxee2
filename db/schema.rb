# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160430052242) do

  create_table "clients", force: :cascade do |t|
    t.string  "client_id"
    t.string  "client_name"
    t.string  "grp_status"
    t.integer "grp_members"
    t.string  "user_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.float   "prt_liability"
    t.integer "tax_year"
    t.float   "penalty_tax",   default: 0.0
    t.float   "interest",      default: 0.0
    t.string  "client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "password_confirmation"
  end

  create_table "wages", force: :cascade do |t|
    t.integer "tax_year"
    t.float   "salary"
    t.float   "super"
    t.float   "fringe_benefits"
    t.float   "contractor_payments"
    t.float   "ess"
    t.float   "allowances"
    t.float   "apprentice_payments"
    t.float   "exempt_wages"
    t.string  "client_id"
    t.float   "interstate_wages"
    t.float   "grp_nsw_wages"
    t.float   "grp_interstate_wages"
  end

end
