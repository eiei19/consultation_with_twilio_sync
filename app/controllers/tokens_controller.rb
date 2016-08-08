class TokensController < ApplicationController
  def sync
    identity = params[:identity]
    endpoint_id = "Consultation:#{params[:identity]}:#{params[:device_id]}"
    token = Twilio::Util::AccessToken.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_API_KEY"],
      ENV["TWILIO_API_SECRET"],
      3600, identity
    )
    grant = Twilio::Util::AccessToken::SyncGrant.new
    grant.service_sid = ENV["TWILIO_SYNC_SERVICE_SID"]
    grant.endpoint_id = endpoint_id
    token.add_grant(grant)
    render json: {identity: params[:identity], token: token.to_jwt}
  end

  def phone
    capability = Twilio::Util::Capability.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_ACCOUNT_AUTH_TOKEN"]
    )
    capability.allow_client_outgoing "APe1a842425cf357990b7b74aa634f3fad"
    capability.allow_client_incoming(params[:identity])
    token = capability.generate
    render json: {identity: params[:identity], token: token}
  end
end