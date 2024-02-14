module KayzenApi
  class AuthenticationToken < Endpoint
    path "authentication/token"

    def self.request_for(**options)
      base_64_encoded_api_key = Base64.encode64("#{App.config.api_key}:#{App.config.secret_api_key}")

      options[:headers] = (options[:headers] || {}).merge({ "Authorization" => "Basic #{base_64_encoded_api_key}" })
      # options.merge!(headers: { "Authorization" => "Basic #{base_64_encoded_api_key}" })
      super
    end
  end
end
