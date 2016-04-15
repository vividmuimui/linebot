class LinebotController < ApplicationController
  before_action :validate_signature

  def callback
    params['result'].each do |message|
      logger.debug(message: message)
      content = Line::RequestContent.new(message['content'])
      Line::MessageSender.send_text_message(users: content.user, text: content.text)
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
