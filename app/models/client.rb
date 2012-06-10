class Client < ActiveRecord::Base

  before_create :generate_acces_tokens
  
  private
    def generate_acces_tokens
      create_api_secret
    end
  
    def create_api_secret
      begin
        self.api_secret = SecureRandom.urlsafe_base64
      end while Client.exists?(:api_secret => self.api_secret)
    end
end
