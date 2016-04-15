module Line
  class MessageSender
    class << self
      def send_text_message(users:, text:)
        send_message(
          users: users,
          content: {
            contentType: 1,
            toType: 1,
            text: text
          }
        )
      end

      def send_message(users:, content:)
        content_json = {
          to: Array(users),
          toChannel: 1383378250,  # Fixed  value
          eventType: "138311608800106203", # Fixed  value,
          content: content
        }.to_json
        p(content_json: content_json)

        RestClient.proxy = ENV["FIXIE_URL"]
        RestClient.post(
          'https://trialbot-api.line.me/v1/events',
          content_json,
          {
            'Content-Type' => 'application/json; charset=UTF-8',
            'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
            'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
            'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
          }
        )
      end
    end
  end
end
