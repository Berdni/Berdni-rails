Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, Rails.application.credentials.vk_api_id!, Rails.application.credentials.vk_api_secret!, lang: 'ru'
end