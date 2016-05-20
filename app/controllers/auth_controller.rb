class AuthController < ApplicationController

  def access_token
    url = "#{params[:redirect_uri]}?access_token=#{ENV['AUTHORIZATION_TOKEN']}"
    
    redirect_to url and return
  end

end
