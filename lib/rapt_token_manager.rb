require 'rapt_api_client'
require 'net/http'
require 'uri'

module RaptTokenManager
  TOKEN_URL = URI('https://id.rapt.io/connect/token')
  CLIENT_ID = 'rapt-user'
  USERNAME = ENV.fetch('RAPT_USERNAME')
  PASSWORD = ENV.fetch('RAPT_PASSWORD')

  CACHE_KEY = 'rapt_api_access_token'
  EXPIRY_BUFFER = 60 # seconds

  def self.fetch_token
    request = Net::HTTP::Post.new(TOKEN_URL)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    request.set_form_data(
      'client_id' => CLIENT_ID,
      'grant_type' => 'password',
      'username' => USERNAME,
      'password' => PASSWORD
    )

    response = Net::HTTP.start(TOKEN_URL.hostname, TOKEN_URL.port, use_ssl: true) do |http|
      http.request(request)
    end

    raise "Token request failed: #{response.code} - #{response.body}" unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    token = data['access_token']
    expires_in = data['expires_in'].to_i

    # Cache with buffer time
    Rails.cache.write(CACHE_KEY, token, expires_in: expires_in - EXPIRY_BUFFER)
    token
  end

  def self.get_token
    Rails.cache.fetch(CACHE_KEY) { fetch_token }
  end
end
