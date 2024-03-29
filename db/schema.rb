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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120804005139) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "polls", :force => true do |t|
    t.text     "response_text"
    t.integer  "response_time"
    t.boolean  "success"
    t.integer  "service_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "healthy"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "uri"
    t.text     "description"
    t.string   "expectation"
    t.integer  "poll_interval"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "api_format"
    t.string   "user_agent"
    t.text     "cookies"
  end

end
