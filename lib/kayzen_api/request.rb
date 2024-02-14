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
      options = add_headers(options)
      target_url = App.config.base_url + @path

      response =
        Typhoeus::Request
          .new(target_url, options)
          .run

      save_oauth_token(response)
      response
    end

    def add_headers(options)
      options[:headers] = (options[:headers] || {}).merge({ "Content-Type" => "application/json" })
      options[:headers] = (options[:headers] || {}).merge({ "Accept" => "application/json"})
      options
    end
  end
end
