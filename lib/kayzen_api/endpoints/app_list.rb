module KayzenApi
  class AppList < Endpoint
    path "app_list"

    # This resource is a special case because the URL is plural for the GET method
    # and singular for the others. We override the target_url method to handle this.
    # See https://developers.kayzen.io/reference/list-app-lists
    def self.target_url(options)
      @path = "app_lists" if options[:method] == :get

      super
    end
  end
end
