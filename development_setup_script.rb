require "dotenv"
require "byebug"
require "./lib/kayzen_api"

Dotenv.load(".env.development")

KayzenApi::App.configure do |config|
  config.api_key = ENV["KAYZEN_API_API_KEY"]
  config.secret_api_key = ENV["KAYZEN_API_SECRET_API_KEY"]
  config.username = ENV["KAYZEN_USERNAME"]
  config.password = ENV["KAYZEN_PASSWORD"]
  config.logger = Logger.new($stdout)
end

KayzenApi::Campaign.get
