class Authorization < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  
  before_create :generate_tokens
  
  private
    def generate_tokens
      create_authorization_token
    end
    
    def create_authorization_token
      begin
        self.authorization_token = SecureRandom.urlsafe_base64
      end while Authorization.exists?(:authorization_token => self.authorization_token)
    end
  
end
