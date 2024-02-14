require "spec_helper"

RSpec.describe KayzenApi::AuthenticationToken do
  subject(:authentication_token) { described_class }

  let(:api_key) { "api_key" }
  let(:secret_api_key) { "secret_api_key" }
  let(:base_64_encoded_api_key) { "YXBpX2tleTpzZWNyZXRfYXBpX2tleQ==\n" }
  let(:oauth_token) { "oauth_token" }
  let(:username) { "username" }
  let(:password) { "secret" }

  describe "create request" do
    let!(:stubbed_request) do
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
        .to_return(mocked_response)
      end

    before do
      KayzenApi::App.configure do |config|
        config.api_key = api_key
        config.secret_api_key = secret_api_key
        config.username = username
        config.password = password
      end
    end

    context "when the request succeeds" do
      let(:mock_authentication_response_body) do
        {
          "access_token" => oauth_token,
          "expires_in" => 3600,
          "scope" => ""
        }
      end

      let(:mocked_response) { { status: 200, body: mock_authentication_response_body.to_json, headers: {} } }

      it "makes a post request, saves the oauth token and returns the response" do
        response = nil

        expect {
          response = authentication_token.create
        }.to change { KayzenApi::App.config.oauth_token }.from(nil).to(oauth_token)

        expect(stubbed_request).to have_been_requested
        expect(response.success).to eq(true)
        expect(response.code).to eq(200)
        expect(response.body).to eq(mock_authentication_response_body)
       end
    end

    context "when the request fails" do
      before do
        KayzenApi::App.configure do |config|
          config.oauth_token = nil
        end
      end

      let(:mock_authentication_response_body) do
        {
          "error" => "Incorrect username/password"
        }
      end

      let(:mocked_response) { { status: 400, body: mock_authentication_response_body.to_json, headers: {} } }

      it "doesn't change the saved token and returns the response" do
        response = nil

        expect {
          response = authentication_token.create
        }.not_to change { KayzenApi::App.config.oauth_token }.from(nil)

        expect(stubbed_request).to have_been_requested
        expect(response.success).to eq(false)
        expect(response.code).to eq(400)
        expect(response.body).to eq(mock_authentication_response_body)
      end
    end
  end
end
