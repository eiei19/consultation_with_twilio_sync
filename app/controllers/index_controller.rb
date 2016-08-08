class IndexController < ApplicationController
  protect_from_forgery except: :voice

  def index
  end

  def voice
    response = Twilio::TwiML::Response.new do |r|
        r.Dial :callerId => params[:from_client_id] do |d|
          d.Client params[:to_client_id]
        end
    end
    render xml: response.text
  end
end