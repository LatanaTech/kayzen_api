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

    # The authorization, headers and response handling are overridden when making an authentication request
    # in the AuthenticationToken class, which is a special case
    def make_request(**options)
      authorize_request!

      options = add_headers(options)

      request = Typhoeus::Request.new(target_url(options), options)
      App.log(request)

      response = request.run
      App.log(response)

      handle_response(response)
    end

    def target_url(options)
      target_url = App.config.base_url + @path
      if options.has_key?(:id)
        add_id_to_path(target_url, options.delete(:id).to_s)
      elsif options.has_key? :path
        [target_url, options.delete(:path).to_s].join("/")
      else
        target_url
      end
    end

    def add_id_to_path(target_url, id)
      if @path.include?(":id")
        # the case when the path contains :id like the following "reports/:id/report_results"
        target_url.gsub!(":id", id)
      else
        # the case when the path doesn't containt :id but there is an id in the options
        # example: KayzenApi::Campaign.get(id: id)
        [target_url, id].join("/")
      end
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

    def parse_body(body)
      return {} if body.nil? || body.empty?

      JSON.parse(body)
    end

    def handle_response(response)
      if response.success?
        Response.new(success: true, code: response.code, body: parse_body(response.body))
      else
        Response.new(success: false, code: response.code, body: parse_body(response.body))
      end
    end
  end
end
