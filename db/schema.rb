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

ActiveRecord::Schema.define(version: 20140925043535) do

  create_table "applications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "status"
    t.string   "password_digest"
    t.integer  "school_id"
    t.integer  "subject_id"
    t.string   "token"
    t.integer  "revision"
  end

  add_index "applications", ["school_id"], name: "index_applications_on_school_id"
  add_index "applications", ["subject_id"], name: "index_applications_on_subject_id"

  create_table "common_titles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "number"
    t.string   "soi"
    t.string   "road"
    t.string   "subdistrict"
    t.string   "district"
    t.string   "province"
    t.string   "zip"
    t.string   "telephone"
    t.string   "fax"
    t.string   "website"
  end

  create_table "schools_subjects", id: false, force: true do |t|
    t.integer "school_id",  null: false
    t.integer "subject_id", null: false
  end

  create_table "sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.integer  "application_id"
  end

  add_index "sessions", ["application_id"], name: "index_sessions_on_application_id"

  create_table "students", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "fname"
    t.string   "lname"
    t.integer  "team_id"
  end

  add_index "students", ["team_id"], name: "index_students_on_team_id"

  create_table "subjects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "teachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "fname"
    t.string   "lname"
    t.integer  "application_id"
  end

  add_index "teachers", ["application_id"], name: "index_teachers_on_application_id"

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
  end

  add_index "teams", ["application_id"], name: "index_teams_on_application_id"

end
