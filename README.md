# KayzenApi

This gem is a wrapper for the [Kayzen REST Api](https://developers.kayzen.io). Kayzen is a bidder for mobile advertising.

## Installation

Add the gem to your Gemfile with:

```ruby
gem 'kayzen_api'
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

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kayzen_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
