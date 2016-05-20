class AlexaRequestsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:alexa_request]


  def alexa_request    
    logger.debug "Request"
    logger.debug request
    
    respond_to do |format|
      format.json { render :json => { message: "ok" } }
    end
  end

end
