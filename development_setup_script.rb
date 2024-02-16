require "dotenv"
require "./lib/kayzen_api"

Dotenv.load(".env.development")

KayzenApi::App.configure do |config|
  config.api_key = ENV["API_KEY"]
  config.secret_api_key = ENV["SECRET_API_KEY"]
  config.username = ENV["USERNAME"]
  config.password = ENV["PASSWORD"]
  config.logger = Logger.new($stdout)
end

KayzenApi::Campaign.get
