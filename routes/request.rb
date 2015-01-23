
class App
  
  get '/contacts/:contacts_id/requests' do
    if uid = session[:uid]
      @return_message[:success] = 1
      @return_message[:requests] = GitContacts::get_all_requests uid
    else
      @return_message[:token] = "Token invalid."
      status 401
    end
    @return_message.to_json
  end

  put '/contacts/:contacts_id/request/:request_id/status' do
    if uid = session[:uid]
      if GitContacts::edit_request_status(uid, params[:contacts_id], params[:request_id], params[:payload])
        @return_message[:success] = 1
      else
        @return_message[:errmsg] = "Change request status failed."
        status 500
      end
    else
      @return_message[:errmsg] = "Token invalid."
      status 401
    end
    @return_message.to_json
  end
end