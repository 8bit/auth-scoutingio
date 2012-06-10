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

ActiveRecord::Schema.define(:version => 20120610000357) do

  create_table "authorizations", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "authorization_token"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "authorizations", ["client_id"], :name => "index_authorizations_on_client_id"
  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "api_token"
    t.string   "api_secret"
    t.string   "callback_url"
    t.string   "return_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "request_token"
    t.string   "access_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "requests", ["client_id"], :name => "index_requests_on_client_id"
  add_index "requests", ["user_id"], :name => "index_requests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
