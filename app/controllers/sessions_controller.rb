class SessionsController < ApplicationController
  def new
  end

  def create
    request = Request.find_by_request_token(params[:request_token])
    user = User.find_by_email(params[:email])
    if request && user && user.authenticate(params[:password])
      session[:user_id] = user.id
      request.user = current_user
      request.save
      Authorization.create(user: current_user, client: request.client)
      redirect_to request.client.callback_url + "?sig=#{request.access_token}"
    else
      render status: :forbidden, :text => "Unable to login."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_back_or_default root_url, :flash => {:success => t(:logout_flash)}
  end
end
