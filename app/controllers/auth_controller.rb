class AuthController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:access_token]

  def access_token
    
    # state=xyz&access_token=2YotnFZFEjr1zCsicMWpAA  
    url = "#{params[:redirect_uri]}?access_token=#{ENV['AUTHORIZATION_TOKEN']}&token_type=Bearer"
    
    data = {
      "access_token": "#{ENV['AUTHORIZATION_TOKEN']}",
      "token_type":"Bearer",
      "expires_in":31533600,
      "refresh_token": "#{ENV['REFRESH_TOKEN']}"
    }
    
    respond_to do |format|
      format.html
      format.json { render :json => data }
    end
  end

end
