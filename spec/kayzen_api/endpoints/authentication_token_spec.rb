require "spec_helper"

RSpec.describe KayzenApi::AuthenticationToken do
  subject(:authentication_token) { described_class }

  let(:api_key) { "api_key" }
  let(:secret_api_key) { "secret_api_key" }
  let(:base_64_encoded_api_key) { "YXBpX2tleTpzZWNyZXRfYXBpX2tleQ==\n" }
  let(:oauth_token) { "oauth_token" }
  let(:username) { "username" }
  let(:password) { "secret" }
  let(:mock_authentication_response) do
    {
      "access_token" => oauth_token,
      "expires_in" => 3600,
      "scope" => ""
    }.to_json
  end

  before do
    KayzenApi::App.configure do |config|
      config.api_key = api_key
      config.secret_api_key = secret_api_key
      config.username = username
      config.password = password
    end
  end

  before do
    @stub =
      stub_request(:post, "https://api.kayzen.io/v1/authentication/token")
        .with(
          body: "grant_type=password&password=#{password}&username=#{username}",
          headers: {
          'Expect'=>'',
          'User-Agent'=>'Typhoeus - https://github.com/typhoeus/typhoeus',
          'Content-Type'=>'application/json',
          'Accept'=>'application/json',
          'Authorization'=> "Basic #{base_64_encoded_api_key}"
          })
        .to_return(status: 200, body: mock_authentication_response, headers: {})
  end

  it "makes a post request and saves the oauth token" do
    expect {
      authentication_token.create
    }.to change { KayzenApi::App.config.oauth_token }.from(nil).to(oauth_token)

    expect(@stub).to have_been_requested
   end
end
