require 'typhoeus'
require 'base64'

module KayzenApi
  module Request
    def get(**options)
      options[:method] = :get
      request_for(**options)
    end

    def create(**options)
      options[:method] = :post
      request_for(**options)
    end

    def update(**options)
      options[:method] = :put
      request_for(**options)
    end

    def delete(**options)
      options[:method] = :delete
      request_for(**options)
    end

    private

    def request_for(**options)
      target_url = App.config.base_url + @path
      options[:headers] = (options[:headers] || {}).merge({ "Content-Type" => "application/json" })
      options[:headers] = (options[:headers] || {}).merge({ "Accept" => "application/json"})

      request = Typhoeus::Request.new(target_url, options)
      response = request.run
      save_oauth_token(request)
      request
    end

    def save_oauth_token(request)
      return unless request.response.code == 200

      json = JSON.parse(request.response.body)
      App.config.oauth_token = json["access_token"]
    end
  end
end
