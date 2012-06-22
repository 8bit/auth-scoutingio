class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :output_debug
  
  def output_debug
    logger.info "Session: " + session.to_s
  end
  
  private
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
    
end
