require "kayzen_api/request"

module KayzenApi
  class Endpoint
    extend Request

    def self.path(value)
      @path = value
    end
  end
end
