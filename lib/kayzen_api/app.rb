require 'dry-configurable'

module KayzenApi
  class App
    extend Dry::Configurable

    setting :base_url, default: "https://api.kayzen.io/v1/"
    setting :oauth_token
    setting :username
    setting :password
    setting :api_key
    setting :secret_api_key
    setting :logger
  end
end
