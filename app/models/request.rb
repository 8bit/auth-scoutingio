class Request < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  
  validates :client_id, :presence => true

  before_create :create_request_token

  def to_param
    permalink
  end
  
  def permalink
    "#{request_token}"
  end 
  
  def user=(obj)
    create_access_token
    super(obj)
  end
  
  private
  
  def create_request_token
    begin
      self.request_token = SecureRandom.urlsafe_base64
    end while Request.exists?(:request_token => self.request_token)
  end
  
  def create_access_token
    begin
      self.access_token = SecureRandom.urlsafe_base64
    end while Request.exists?(:access_token => self.access_token)
  end
  
end
