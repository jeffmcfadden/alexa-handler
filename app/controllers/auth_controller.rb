class AuthController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:access_token]

  def access_token
    url = "#{params[:redirect_uri]}?access_token=#{ENV['AUTHORIZATION_TOKEN']}"
    
    redirect_to url and return
  end

end
