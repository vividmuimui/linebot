class LinebotController < ApplicationController
  before_action :validate_signature

  def callback
    params = JSON.parse(request.body.read)
    p(params: params)

    params['result'].each do |msg|
      request_content = {
        to: [msg['content']['from']],
        toChannel: 1383378250, # Fixed  value
        eventType: "138311608800106203", # Fixed value
        content: msg['content']
      }
      p(request_content: request_content)

      endpoint_uri = 'https://trialbot-api.line.me/v1/events'
      content_json = request_content.to_json
      p(content_json: content_json)
      RestClient.proxy = ENV["FIXIE_URL"]
      RestClient.post(endpoint_uri, content_json, {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
        'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
        'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
      })
    end

    head status: :ok
  end

  private

  def validate_signature
    channel_secret = ENV["LINE_CHANNEL_SECRET"]
    http_request_body = request.raw_post
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, channel_secret, http_request_body)
    signature = Base64.strict_encode64(hash)
    if signature != request.headers["X-LINE-CHANNELSIGNATURE"]
      head status: :ng
    end
  end
end
