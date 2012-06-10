class RequestsController < ApplicationController
  # POST /requests
  # POST /requests.json
  def create
    client = Client.find_by_api_token_and_api_secret(params[:api_token], params[:api_secret])
    
    if client && current_user && Authorization.find_by_user_id_and_client_id(current_user.id, client.id)
      request = Request.new(:client => client)
      request.user = current_user
      request.save
      redirect_to request.client.callback_url + "?sig=#{request.access_token}"
    else
      @request = Request.new(:client => client)
    
      respond_to do |format|
        if @request.save
          format.json { render json: @request, status: :created, location: @request }
        else
          format.json { render json: @request.errors, status: :forbidden }
        end
      end
    end
  end
end
