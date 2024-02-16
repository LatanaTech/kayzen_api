# KayzenApi

This gem is a wrapper for the [Kayzen REST Api](https://developers.kayzen.io). Kayzen is a bidder for mobile advertising.

## Installation

Add the gem to your Gemfile with:

```ruby
gem 'kayzen_api', git: "https://github.com/LatanaTech/kayzen_api"
```

and then run `bundle install`.

## Configuration and Authentication

The gem must be configured with the following options (we recommend adding this to an initializer in your application):

```ruby
KayzenApi::App.configure do |config|
  config.api_key = "api-key"
  config.secret_api_key = "secret-api-key"
  config.username = "username"
  config.password = "password"
end
```

The Kayzen API has an `authentication/token` endpoint which issues an Oauth token that expires after 30 minutes. This gem ensures that there is always a valid Oauth token present before making a request (and requests that token if not).

Your application code does not need to explicitly make an authentication request - the gem will do this if one is neccessary.

## Usage

Example usage:

```ruby
# Makes a request to https://api.kayzen.io/v1/campaigns
KayzenApi::Campaign.get

# The gem returns a Response object, where the body attribute contains the body of the API response from Kayzen
# <KayzenApi::Response success=true code=200 body=[]>
```

## Development

1. Clone this repo
2. Ensure you have the ruby-version defined in `.ruby-version`
3. `bundle install` to install all the gems
4. Open an IRB console with the gem loaded: `irb -I lib -r  ./lib/kayzen_api.rb`

For linting, run `standardrb --fix`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kayzen_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
