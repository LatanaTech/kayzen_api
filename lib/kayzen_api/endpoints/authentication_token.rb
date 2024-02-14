module KayzenApi
  class AuthenticationToken < Endpoint
    path "authentication/token"

    def self.add_headers(options)
      body_params = { username: App.config.username, password: App.config.password, grant_type: "password" }
      base_64_encoded_api_key = Base64.encode64("#{App.config.api_key}:#{App.config.secret_api_key}")

      options[:body] = body_params
      options[:headers] = (options[:headers] || {}).merge({ "Authorization" => "Basic #{base_64_encoded_api_key}" })

      super
    end

    def self.save_oauth_token(response)
      return unless response.success?

      oauth_token = JSON.parse(response.body).fetch("access_token")
      App.config.oauth_token = oauth_token
    end
  end
end
