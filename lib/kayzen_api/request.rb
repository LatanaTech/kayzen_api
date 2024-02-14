require 'typhoeus'
require 'base64'

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

      response =
        Typhoeus::Request
          .new(target_url, options)
          .run

      handle_response(response)
    end

    def authorize_request!
      return if App.config.oauth_token.present? && App.config.oauth_token.valid?

      AuthenticationToken.create
    end

    def add_headers(options)
      options[:headers] = (options[:headers] || {}).merge({ "Content-Type" => "application/json" })
      options[:headers] = (options[:headers] || {}).merge({ "Accept" => "application/json"})
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
