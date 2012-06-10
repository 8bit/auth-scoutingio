class Client < ActiveRecord::Base

  before_create :generate_acces_tokens
  
  private
    def generate_acces_tokens
      create_api_token
      create_api_secret
    end
    
    def create_api_token
      self.api_token = rand(36**8).to_s(36) if self.api_token.nil?
    end 
  
    def create_api_secret
      begin
        self.api_secret = SecureRandom.urlsafe_base64
      end while Client.exists?(:api_secret => self.api_secret)
    end
end
