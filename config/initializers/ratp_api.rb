require 'rapt_api_client'

RaptApiClient.configure do |config|
  config.scheme = "https"
  config.host = ENV.fetch('RAPT_API_HOST', 'https://api.rapt.io/')
  config.access_token_getter = -> { RaptTokenManager.get_token }
  config.debugging = ENV.fetch('RAPT_API_DEBUG', false)
end
