require 'typhoeus'

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
      target_url = App.config.base_url + options[:path]

      if options.has_key?(:body_params)
        options[:headers] = { "Content-Type" => "application/json" }
      end

      request = Typhoeus::Request.new(target_url, options)



      # if self.class == AuthenticationToken
      # end
    end
  end
end
