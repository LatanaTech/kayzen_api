module KayzenApi
  class App
    extend Dry::Configurable

    setting :base_url, default: "https://api.kayzen.io/v1/"
    setting :grant_type, default: "password"
    setting :logger
    setting :username
    setting :password

  end
end
