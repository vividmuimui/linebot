class LinebotController < ApplicationController
  before_action :validate_signature

  def callback
    params = JSON.parse(request.body.read)
    p(params: params)

    params['result'].each do |msg|
      content = msg['content']
      p(content: content)
      Line::MessageSender.send_text_message(
        users: content['from'],
        text: content['text']
      )
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
