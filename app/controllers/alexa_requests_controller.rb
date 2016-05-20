require 'open3'

class AlexaRequestsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:alexa_request]


  def alexa_request    
    logger.debug "Request"
    logger.debug request
    
    
    #I, [2016-05-20T15:27:01.051047 #3007]  INFO -- :   Parameters: {"header"=>{"namespace"=>"Alexa.ConnectedHome.Discovery", "name"=>"DiscoverAppliancesRequest", "payloadVersion"=>"2", "messageId"=>"5fa10024-f060-401a-85de-54400cea84cb"}, "payload"=>{"accessToken"=>"hPjjianfrBwXA8EkafAP6Hd"}, "alexa_request"=>{"header"=>{"namespace"=>"Alexa.ConnectedHome.Discovery", "name"=>"DiscoverAppliancesRequest", "payloadVersion"=>"2", "messageId"=>"5fa10024-f060-401a-85de-54400cea84cb"}, "payload"=>{"accessToken"=>"hPjjianfrBwXA8EkafAP6Hd"}}}
    
    response_message_id = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    
    #I, [2016-05-20T15:49:08.304800 #3195]  INFO -- :   Parameters: {"header"=>{"namespace"=>"Alexa.ConnectedHome.Control", "name"=>"TurnOnRequest", "payloadVersion"=>"2", "messageId"=>"965a3eed-b78b-40e3-b50e-3c5de6db0e42"}, "payload"=>{"accessToken"=>"hPjjianfrBwXA8EkafAP6Hd", "appliance"=>{"applianceId"=>"kitchenLightsID1234", "additionalApplianceDetails"=>{}}}, "alexa_request"=>{"header"=>{"namespace"=>"Alexa.ConnectedHome.Control", "name"=>"TurnOnRequest", "payloadVersion"=>"2", "messageId"=>"965a3eed-b78b-40e3-b50e-3c5de6db0e42"}, "payload"=>{"accessToken"=>"hPjjianfrBwXA8EkafAP6Hd", "appliance"=>{"applianceId"=>"kitchenLightsID1234", "additionalApplianceDetails"=>{}}}}}
    
    
    if params["header"]["namespace"] == "Alexa.ConnectedHome.Discovery"
      data =  data_for_discovery_request
    elsif true || params["header"]["namespace"] == "Alexa.ConnectedHome.Control" && params["header"]["name"] == "TurnOnRequest"
      stdout, stdeerr, status = Open3.capture3("/usr/local/bin/zway kitchen_lights on")
      puts "Output: " + stdout
      puts "Error: "  + stdeerr
      data = data_for_turn_on_request
    elsif params["header"]["namespace"] == "Alexa.ConnectedHome.Control" && params["header"]["name"] == "TurnOffRequest"
      stdout, stdeerr, status = Open3.capture3("/usr/local/bin/zway kitchen_lights off")
      puts "Output: " + stdout
      puts "Error: "  + stdeerr
      data = data_for_turn_off_request
    end
    
    respond_to do |format|
      format.json { render :json => data }
    end
  end
  
  def data_for_discovery_request
    response_message_id = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    
    {
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
  end
  
  def data_for_turn_on_request
    response_message_id = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    
    {
        "header": {
            "messageId": "#{response_message_id}",
            "name": "TurnOnConfirmation",
            "namespace": "Alexa.ConnectedHome.Control",
            "payloadVersion": "2"
        },
        "payload": {}
    }
  end
  
  def data_for_turn_off_request    
    response_message_id = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
    
    {
        "header": {
            "messageId": "#{response_message_id}",
            "name": "TurnOffConfirmation",
            "namespace": "Alexa.ConnectedHome.Control",
            "payloadVersion": "2"
        },
        "payload": {}
    }
  end
  

end
