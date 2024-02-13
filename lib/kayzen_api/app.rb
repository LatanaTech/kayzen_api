module KayzenApi
  class App
    extend Dry::Configurable

    setting :base_url, default: "https://api.kayzen.io/v1/"
    setting :oauth_token
    setting :username
    setting :password
    setting :grant_type, default: "password"
    setting :logger
  end
end
