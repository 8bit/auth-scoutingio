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

ActiveRecord::Schema.define(:version => 20120610145429) do

  create_table "authorizations", :force => true do |t|
    t.integer  "request_id"
    t.integer  "client_id"
    t.integer  "user_id"
    t.string   "authorization_code"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.datetime "code_expires_at"
  end

  add_index "authorizations", ["client_id"], :name => "index_authorizations_on_client_id"
  add_index "authorizations", ["request_id"], :name => "index_authorizations_on_request_id"
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
    t.string   "response_type"
    t.string   "client_id"
    t.string   "scope"
    t.string   "redirect_uri"
    t.string   "nonce"
    t.string   "state"
    t.text     "request"
    t.string   "request_uri"
    t.string   "display"
    t.string   "prompt"
    t.text     "id_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
