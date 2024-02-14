require "spec_helper"

RSpec.describe KayzenApi::AuthenticationToken do
  subject(:authentication_token) { described_class }
  let(:api_key) { "api_key" }
  let(:secret_api_key) { "secret_api_key" }
  let(:base_64_encoded_api_key) { "YXBpX2tleTpzZWNyZXRfYXBpX2tleQ==\n" }
  # let(:headers) { { "Content-Type" => "application/json" } }

  before do
    KayzenApi::App.configure do |config|
      config.api_key = api_key
      config.secret_api_key = secret_api_key
      config.username = "username"
      config.password = "secret"
      config.grant_type = "password"
    end
  end

  before do
    @stub =
      stub_request(:post, "https://api.kayzen.io/v1/authentication/token")
        .with(
          body: "grant_type=password&password=secret&username=username",
          headers: {
          'Expect'=>'',
          'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus',
          'Content-Type'=>'application/json',
          'Accept'=>'application/json',
          'Authorization'=> "Basic #{base_64_encoded_api_key}"
          })
        .to_return(status: 200, body: "", headers: {})
  end

  it "makes a post request" do
    body_params = { username: "username", password: "secret", grant_type: "password" }
    response = authentication_token.create(body: body_params)

    expect(@stub).to have_been_requested
   end
end
