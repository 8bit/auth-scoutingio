class Authorization < ActiveRecord::Base
  # create_table "authorizations", :force => true do |t|
  #   t.integer  "request_id"
  #   t.integer  "client_id"
  #   t.integer  "user_id"
  #   t.string   "authorization_code"
  #   t.string   "access_token"
  #   t.string   "refresh_token"
  #   t.datetime "created_at",         :null => false
  #   t.datetime "updated_at",         :null => false
  # end
  # 
  # add_index "authorizations", ["client_id"], :name => "index_authorizations_on_client_id"
  # add_index "authorizations", ["request_id"], :name => "index_authorizations_on_request_id"
  # add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  belongs_to :request
  belongs_to :client
  belongs_to :user
  
  validates :request_id, :client_id, :user_id, :presence => true
  
  before_create :generate_tokens
  
  def generate_authorization_code
    self.authorization_code = rand(36**8).to_s(36)
    self.code_expires_at = Time.now + 10.minutes
  end 
  
  
  private
    def generate_tokens
      generate_authorization_code
      generate_access_token
      generate_refresh_token
    end
        
    def generate_access_token
      begin
        self.access_token = SecureRandom.urlsafe_base64
      end while Authorization.exists?(:access_token => self.access_token)
    end

    def generate_refresh_token
      begin
        self.refresh_token = SecureRandom.urlsafe_base64
      end while Authorization.exists?(:refresh_token => self.refresh_token)
    end
  
end
