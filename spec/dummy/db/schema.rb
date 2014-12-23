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

ActiveRecord::Schema.define(version: 20141222192246) do

  create_table "blogdiggity_contributors", force: true do |t|
    t.string   "company"
    t.string   "email"
    t.string   "github_url"
    t.string   "image"
    t.string   "location"
    t.string   "name"
    t.string   "nickname"
    t.string   "provider"
    t.string   "repos_url"
    t.string   "token"
    t.string   "uid"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "status",     default: "pending", null: false
  end

  add_index "blogdiggity_contributors", ["nickname"], name: "index_blogdiggity_contributors_on_nickname", unique: true

  create_table "blogdiggity_pages", force: true do |t|
    t.integer  "repository_id"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "published"
    t.datetime "published_at"
    t.string   "extension"
  end

  add_index "blogdiggity_pages", ["slug"], name: "index_blogdiggity_pages_on_slug", unique: true

  create_table "blogdiggity_repositories", force: true do |t|
    t.integer  "contributor_id"
    t.string   "name"
    t.string   "sha"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
