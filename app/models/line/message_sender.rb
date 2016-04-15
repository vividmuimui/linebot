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
        content = build_content(users: users, content: content)
        logger.debug(content: content)
        RestClient.proxy = ENV["FIXIE_URL"]
        RestClient.post(request_url, content.json, request_headers)
      end

      private

      def build_content(users:, content:)
        content_json = {
          to: Array(users),
          toChannel: 1383378250,  # Fixed  value
          eventType: "138311608800106203", # Fixed  value,
          content: content
        }
      end

      def request_url
        'https://trialbot-api.line.me/v1/events'
      end

      def request_headers
        {
          'Content-Type' => 'application/json; charset=UTF-8',
          'X-Line-ChannelID' => ENV["LINE_CHANNEL_ID"],
          'X-Line-ChannelSecret' => ENV["LINE_CHANNEL_SECRET"],
          'X-Line-Trusted-User-With-ACL' => ENV["LINE_CHANNEL_MID"],
        }
      end
    end
  end
end
