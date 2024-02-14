require 'kayzen_api/request'

module KayzenApi
  class Endpoint
    extend Request

    def self.path(value)
      @path = value
    end

    def self.save_oauth_token(response)
      return
    end
  end
end
