Rails.application.routes.draw do
  post 'linebot/callback' => 'linebot#callback'
end
