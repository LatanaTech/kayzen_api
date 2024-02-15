require 'json'

module KayzenApi
  class AuthenticationToken < Endpoint
    path "authentication/token"

    class << self

      private

      def authorize_request!
        raise Errors::MissingConfiguration.new("Username is required") unless App.config.username
        raise Errors::MissingConfiguration.new("Password is required") unless App.config.password
        raise Errors::MissingConfiguration.new("API Key is required") unless App.config.api_key
        raise Errors::MissingConfiguration.new("Secret API Key is required") unless App.config.secret_api_key
      end

      def add_headers(options)
        body_params = { username: App.config.username, password: App.config.password, grant_type: "password" }
        base_64_encoded_api_key = Base64.strict_encode64("#{App.config.api_key}:#{App.config.secret_api_key}")

        options[:body] = body_params.to_json
        options[:headers] = (options[:headers] || {}).merge({ "Authorization" => "Basic #{base_64_encoded_api_key}" })

        super
      end

      def handle_response(response)
        return super unless response.success?

        oauth_token = JSON.parse(response.body).fetch("access_token")
        expires_in = JSON.parse(response.body).fetch("expires_in").to_i
        expires_at = (Time.now + expires_in) - 60
        App.config.oauth_token = oauth_token
        App.config.oauth_token_expires_at = expires_at

        super
      end
    end
  end
end
