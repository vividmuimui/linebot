class LinebotController < ApplicationController
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
end
