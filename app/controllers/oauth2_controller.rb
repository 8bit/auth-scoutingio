class Oauth2Controller < ApplicationController
  def authorize
    request_params = params
    request_params.delete("controller")
    request_params.delete("action")
    request = Request.new(params)
    if request.valid?
      if client = Client.find_by_api_token(request.client_id)
        request.save
        if current_user && auth = Authorization.find_or_create_by_client_id_and_user_id(client.id, current_user.id)
          auth.generate_authorization_code
          auth.save
          url = request.redirect_uri + "?code=#{auth.authorization_code}"
          url += "&state=#{request.state}" if request.state
          redirect_to url
        else
          session[:request_id] = request.id
          redirect_to login_path
        end
      else
        render json: {:error => 'unauthorized_client'}, status: 400
      end
    else
      render json: {:error => request.errors.messages.first.second[0]}, status: 400
    end
  end
  
  def token
    client = Client.find_by_api_token_and_api_secret(params[:client_id], params[:client_secret])
    auth = Authorization.find_by_authorization_code_and_client_id(params[:code], client.id) if client
    if client && auth
      render json: { access_token: auth.access_token}, status: 200
    else
      render status: 400, text: "bad_request"
    end
  end
  
  def user_info
    
  end
  
  def test
    render json: params, status: 200
  end
end
