class Request < ActiveRecord::Base
  # create_table "requests", :force => true do |t|
  #   t.string   "response_type"
  #   t.string   "client_id"
  #   t.string   "scope"
  #   t.string   "redirect_uri"
  #   t.string   "nonce"
  #   t.string   "state"
  #   t.text     "request"
  #   t.string   "request_uri"
  #   t.string   "display"
  #   t.string   "prompt"
  #   t.text     "id_token"
  #   t.datetime "created_at",    :null => false
  #   t.datetime "updated_at",    :null => false
  # end
  
  validates :response_type, :client_id, :scope, :redirect_uri, :presence => {:message => "invalid_request" }
  validates :response_type, :inclusion => { :in => ["code", "token", "id_token", "code id_token"],
      :message => "unsupported_response_type" }
  validates_each :scope do |record, attr, value|
    record.errors.add(attr, 'invalid_scope') if value.blank? || (value.split(" ") - ["openid", "profile", "email", "address", "phone", "claims_in_id_token"]).present? || !value.split(" ").include?("openid")
  end
end
