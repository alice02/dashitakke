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

ActiveRecord::Schema.define(version: 20150925114241) do

  create_table "answers", force: true do |t|
    t.string   "status",        null: false
    t.string   "checked_by"
    t.integer  "paper_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "assignment_id"
  end

  add_index "answers", ["assignment_id"], name: "index_answers_on_assignment_id"
  add_index "answers", ["paper_id"], name: "index_answers_on_paper_id"
  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "assignments", force: true do |t|
    t.integer  "paper_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["paper_id"], name: "index_assignments_on_paper_id"
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id"

  create_table "papers", force: true do |t|
    t.integer  "index",                      null: false
    t.date     "given_date",                 null: false
    t.boolean  "set",        default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "index",      null: false
    t.string   "need_check", null: false
    t.integer  "point",      null: false
    t.text     "contents"
    t.integer  "paper_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["paper_id"], name: "index_questions_on_paper_id"

  create_table "roles", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  create_table "sources", force: true do |t|
    t.string   "src"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["answer_id"], name: "index_sources_on_answer_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attendnumber",                        null: false
    t.string   "number",                              null: false
    t.string   "name",                                null: false
    t.integer  "fighting_power",         default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
