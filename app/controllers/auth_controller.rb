class AuthController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:access_token]

  def access_token
    
    # state=xyz&access_token=2YotnFZFEjr1zCsicMWpAA  
    url = "#{params[:redirect_uri]}?access_token=#{ENV['AUTHORIZATION_TOKEN']}&token_type=Bearer"
    
    redirect_to url and return
  end

end
