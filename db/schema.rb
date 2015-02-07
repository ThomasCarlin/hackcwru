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

ActiveRecord::Schema.define(version: 20150207154631) do

  create_table "educations", force: true do |t|
    t.string   "school"
    t.string   "schoolcode"
    t.string   "city"
    t.string   "state"
    t.string   "degreetype"
    t.string   "degree"
    t.string   "graddate"
    t.string   "mgpa"
    t.string   "gpa"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["resume_id"], name: "index_educations_on_resume_id"

  create_table "entities", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "degree"
    t.string   "major"
    t.string   "position"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic"
  end

  create_table "entity_resumes", force: true do |t|
    t.integer  "resumeid"
    t.integer  "entityid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information", force: true do |t|
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "information", ["resume_id"], name: "index_information_on_resume_id"

  create_table "objectives", force: true do |t|
    t.string   "position"
    t.string   "date"
    t.boolean  "fulltime"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "objectives", ["resume_id"], name: "index_objectives_on_resume_id"

  create_table "resumes", force: true do |t|
    t.string   "title"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", force: true do |t|
    t.string   "company"
    t.string   "position"
    t.string   "datestart"
    t.string   "dateend"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "works", ["resume_id"], name: "index_works_on_resume_id"

end
