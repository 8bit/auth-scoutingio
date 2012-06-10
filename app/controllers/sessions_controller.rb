class SessionsController < ApplicationController
  def new
  end

  def create
    request = Request.find(session[:request_id]) if session[:request_id]
    client = Client.find_by_api_token(request.client_id) if request
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if request
        auth = Authorization.find_or_create_by_client_id_and_user_id(client.id, current_user.id)
        auth.generate_authorization_code
        auth.save
        url = request.redirect_uri + "?code=#{auth.authorization_code}"
        url += "&state=#{request.state}" if request.state
        redirect_to url
      else
        render status: 200, :text => "Login success"
      end
    else
      render status: :forbidden, :text => "Unable to login."
    end
  end

  def destroy
    session[:user_id] = nil
    render status: 200, :text => "Logout success"
  end
end
