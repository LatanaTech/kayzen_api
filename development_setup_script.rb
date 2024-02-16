require './lib/kayzen_api'

username = "your-username-here"
password = "your-password-here"
api_key = "your-api-key-here"
secret_api_key = "your=secret-api-key-here"

KayzenApi::App.configure do |config|
  config.api_key = api_key
  config.secret_api_key = secret_api_key
  config.username = username
  config.password = password
end

campaigns = KayzenApi::Campaign.get
