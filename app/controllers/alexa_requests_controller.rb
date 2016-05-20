class AlexaRequestsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:alexa_request]


  def alexa_request    
    logger.debug "Request"
    logger.debug request
    
    
    #I, [2016-05-20T15:27:01.051047 #3007]  INFO -- :   Parameters: {"header"=>{"namespace"=>"Alexa.ConnectedHome.Discovery", "name"=>"DiscoverAppliancesRequest", "payloadVersion"=>"2", "messageId"=>"5fa10024-f060-401a-85de-54400cea84cb"}, "payload"=>{"accessToken"=>"hPjjianfrBwXA8EkafAP6Hd"}, "alexa_request"=>{"header"=>{"namespace"=>"Alexa.ConnectedHome.Discovery", "name"=>"DiscoverAppliancesRequest", "payloadVersion"=>"2", "messageId"=>"5fa10024-f060-401a-85de-54400cea84cb"}, "payload"=>{"accessToken"=>"hPjjianfrBwXA8EkafAP6Hd"}}}
    
    response_message_id = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    
    if true || params["header"]["namespace"] == "Alexa.ConnectedHome.Discovery"
      data =  {
          "header": {
              "messageId": "#{response_message_id}",
              "name": "DiscoverAppliancesResponse",
              "namespace": "Alexa.ConnectedHome.Discovery",
              "payloadVersion": "2"
          },
          "payload": {
              "discoveredAppliances": [
                  {
                      "actions": [
                          "turnOn",
                          "turnOff"
                      ],
                      "additionalApplianceDetails": {},
                      "applianceId": "kitchenLightsID1234",
                      "friendlyDescription": "Kitchen Lights",
                      "friendlyName": "Kitchen",
                      "isReachable": true,
                      "manufacturerName": "jeffMcFaddenManufacturer",
                      "modelName": "fancyLight",
                      "version": "1.0.0"
                  }
              ]
          }
      }
    else
      data = {}
    end
    
    
    respond_to do |format|
      format.json { render :json => data }
    end
  end

end
