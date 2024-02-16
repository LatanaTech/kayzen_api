require './lib/kayzen_api'

username = "jonathan.senior@latana.com"
password = "NGXgNwhS^2O@FL8$"
api_key = "85c7cb16595741234eca24fda76d9eca6b1e02fd"
secret_api_key = "8w1AGZiMhFs7t5vK"

KayzenApi::App.configure do |config|
  config.api_key = api_key
  config.secret_api_key = secret_api_key
  config.username = username
  config.password = password
end

campaigns = KayzenApi::Campaign.get
