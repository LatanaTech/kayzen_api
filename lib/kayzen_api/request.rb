require "typhoeus"
require "base64"
require "json"

module KayzenApi
  module Request
    def get(**options)
      options[:method] = :get
      make_request(**options)
    end

    def create(**options)
      options[:method] = :post
      make_request(**options)
    end

    def update(**options)
      options[:method] = :put
      make_request(**options)
    end

    def delete(**options)
      options[:method] = :delete
      make_request(**options)
    end

    private

    def make_request(**options)
      authorize_request!

      options = add_headers(options)
      target_url = App.config.base_url + @path

      request = Typhoeus::Request.new(target_url, options)

      pp request

      response = request.run

      pp response

      handle_response(response)
    end

    def token_is_valid?
      return false if App.config.oauth_token.nil?
      return false if App.config.oauth_token_expires_at.nil?

      App.config.oauth_token_expires_at > Time.now
    end

    def authorize_request!
      return if token_is_valid?

      AuthenticationToken.create
    end

    def add_headers(options)
      options[:headers] = (options[:headers] || {}).merge({"Content-Type" => "application/json"})
      options[:headers] = (options[:headers] || {}).merge({"Accept" => "application/json"})
      options[:headers] = (options[:headers] || {}).merge({"Authorization" => "Bearer #{App.config.oauth_token}"}) if token_is_valid?
      options
    end

    def handle_response(response)
      if response.success?
        Response.new(success: true, code: response.code, body: JSON.parse(response.body))
      else
        Response.new(success: false, code: response.code, body: JSON.parse(response.body))
      end
    end
  end
end
