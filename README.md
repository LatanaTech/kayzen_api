# KayzenApi

This gem is a wrapper for the [Kayzen REST Api](https://developers.kayzen.io). Kayzen is a bidder for mobile advertising.

## Installation

Add the gem to your Gemfile with:

```ruby
gem 'kayzen_api', git: "https://github.com/LatanaTech/kayzen_api"
```

and then run `bundle install`.

## Configuration

The gem must be configured with the following options (we recommend adding this to an initializer in your application):

```ruby
KayzenApi::App.configure do |config|
  config.api_key = "api-key"
  config.secret_api_key = "secret-api-key"
  config.username = "username"
  config.password = "password"
end
```

Optionally, you can also pass a custom logger like this (by default the gem will not generate logs):

```ruby
KayzenApi::App.configure do |config|
  config.logger = Rails.logger # Could also use Logger.new(STDOUT)
end
```

## Authentication

The Kayzen API has an `authentication/token` endpoint which issues an Oauth token that expires after 30 minutes. This gem ensures that there is always a valid Oauth token present before making a request (and requests that token if not).

Your application code does not need to explicitly make an authentication request - the gem will do this if one is neccessary.

## Usage

To start work with `Beeswaxapi` you need setup your config.

### Configuration

Example configuration for basic auth authentication:

```ruby
KayzenApi::App.configure do |config|
  config.api_key = ENV["KAYZEN_API_API_KEY"]
  config.secret_api_key = ENV["KAYZEN_API_SECRET_API_KEY"]
  config.username = ENV["KAYZEN_USERNAME"]
  config.password = ENV["KAYZEN_PASSWORD"]
  config.logger = Logger.new($stdout)
end
```

```ruby
# Makes a request to https://api.kayzen.io/v1/campaigns
KayzenApi::Campaign.get

# The gem returns a Response object, where the body attribute contains the body of the API response from Kayzen
# <KayzenApi::Response success=true code=200 body=[]>
```

```ruby
# Make a request with custom path and params
 KayzenApi::Report.get(path: "866803/report_results", params: {start_date: "2024-
02-01", end_date: "2024-02-19"})
```

```ruby
# Make a request for creating an entity (POST)
KayzenApi::CreativesBulk.create(body: {creatives: [params]})
```


## Development

1. Clone this repo
2. Ensure you have the ruby-version defined in `.ruby-version`
3. `bundle install` to install all the gems
4. `cp .env .env.development` then add your Kayzen credentials to `.env.development`
5. Open an IRB console with the gem loaded: `irb -I lib -r  ./lib/kayzen_api.rb`
6. Run the script at `development_setup_script.rb` to configure the gem with your credentials from the `.env.development` file

For linting, run `standardrb --fix`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kayzen_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
