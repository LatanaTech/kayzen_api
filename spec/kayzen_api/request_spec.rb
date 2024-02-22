class KayzenApi::FakeEndpoint < KayzenApi::Endpoint
  path "fake_endpoint"
end

class KayzenApi::FakeEndpointWithId < KayzenApi::Endpoint
  path "fake_endpoint/:id/status"
end

RSpec.describe KayzenApi::Request do
  context "when the oauth token is present and not about to expire" do
    let(:oauth_token) { "fake_oauth_token" }
    let!(:stubbed_request) do
      stub_request(:get, "https://api.kayzen.io/v1/fake_endpoint")
        .with(
          headers: {
            "Authorization" => "Bearer #{oauth_token}",
            "Accept" => "application/json",
            "Content-Type" => "application/json",
            "Expect" => "",
            "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
          }
        )
        .to_return(mocked_response)
    end

    before do
      KayzenApi::App.configure do |config|
        config.oauth_token = oauth_token
        config.oauth_token_expires_at = Time.now + 3600
      end
    end

    context "when the request succeeds" do
      let(:mocked_response) { {status: 200, body: mock_response_body.to_json, headers: {}} }
      let(:mock_response_body) { {"fake_response" => "fake_response"} }

      it "returns a success response" do
        response = KayzenApi::FakeEndpoint.get

        expect(stubbed_request).to have_been_requested
        expect(response.success).to eq(true)
        expect(response.code).to eq(200)
        expect(response.body).to eq(mock_response_body)
      end

      context "when `path` is present" do
        let!(:stubbed_request) do
          stub_request(:get, "https://api.kayzen.io/v1/fake_endpoint/id")
            .with(
              headers: {
                "Authorization" => "Bearer #{oauth_token}",
                "Accept" => "application/json",
                "Content-Type" => "application/json",
                "Expect" => "",
                "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
              }
            )
            .to_return(mocked_response)
        end

        it "returns a success response" do
          response = KayzenApi::FakeEndpoint.get(path: "id")

          expect(stubbed_request).to have_been_requested
          expect(response.success).to eq(true)
          expect(response.code).to eq(200)
          expect(response.body).to eq(mock_response_body)
        end
      end

      context "when `id` is present" do
        let!(:stubbed_request) do
          stub_request(:get, "https://api.kayzen.io/v1/fake_endpoint/123")
            .with(
              headers: {
                "Authorization" => "Bearer #{oauth_token}",
                "Accept" => "application/json",
                "Content-Type" => "application/json",
                "Expect" => "",
                "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
              }
            )
            .to_return(mocked_response)
        end

        it "returns a success response" do
          response = KayzenApi::FakeEndpoint.get(id: 123)

          expect(stubbed_request).to have_been_requested
          expect(response.success).to eq(true)
          expect(response.code).to eq(200)
          expect(response.body).to eq(mock_response_body)
        end

        context "when an endpoint wiht :id in the path" do
          let!(:stubbed_request) do
            stub_request(:get, "https://api.kayzen.io/v1/fake_endpoint/123/status")
              .with(
                headers: {
                  "Authorization" => "Bearer #{oauth_token}",
                  "Accept" => "application/json",
                  "Content-Type" => "application/json",
                  "Expect" => "",
                  "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
                }
              )
              .to_return(mocked_response)
          end

          it "returns a success response" do
            response = KayzenApi::FakeEndpointWithId.get(id: 123)

            expect(stubbed_request).to have_been_requested
            expect(response.success).to eq(true)
            expect(response.code).to eq(200)
            expect(response.body).to eq(mock_response_body)
          end
        end
      end

      context "when `id` is in options and in path present" do
        let!(:stubbed_request) do
          stub_request(:get, "https://api.kayzen.io/v1/fake_endpoint/id")
            .with(
              headers: {
                "Authorization" => "Bearer #{oauth_token}",
                "Accept" => "application/json",
                "Content-Type" => "application/json",
                "Expect" => "",
                "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
              }
            )
            .to_return(mocked_response)
        end

        it "returns a success response" do
          response = KayzenApi::FakeEndpoint.get(id: "id")

          expect(stubbed_request).to have_been_requested
          expect(response.success).to eq(true)
          expect(response.code).to eq(200)
          expect(response.body).to eq(mock_response_body)
        end
      end

      context "when `body` is present" do
        let!(:stubbed_request) do
          stub_request(:post, "https://api.kayzen.io/v1/fake_endpoint")
            .with(
              headers: {
                "Authorization" => "Bearer #{oauth_token}",
                "Accept" => "application/json",
                "Content-Type" => "application/json",
                "Expect" => "",
                "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
              },
              body: "{\"id\":\"id\"}"
            )
            .to_return(mocked_response)
        end

        it "returns a success response" do
          response = KayzenApi::FakeEndpoint.create(body: {id: "id"}.to_json)

          expect(stubbed_request).to have_been_requested
          expect(response.success).to eq(true)
          expect(response.code).to eq(200)
          expect(response.body).to eq(mock_response_body)
        end
      end
    end

    context "when the request fails" do
      let(:mocked_response) { {status: 500, body: mock_response_body.to_json, headers: {}} }
      let(:mock_response_body) { {"error" => "fake_error"} }

      it "returns an error response" do
        response = KayzenApi::FakeEndpoint.get

        expect(stubbed_request).to have_been_requested
        expect(response.success).to eq(false)
        expect(response.code).to eq(500)
        expect(response.body).to eq(mock_response_body)
      end
    end
  end

  context "when the oauth token has expired" do
    let(:old_oauth_token) { "old_oauth_token" }
    let(:new_oauth_token) { "new_oauth_token" }
    let(:api_key) { "fake_api_key" }
    let(:secret_api_key) { "fake_secret_api_key" }
    let(:username) { "fake_username" }
    let(:password) { "fake_password" }

    before do
      KayzenApi::App.configure do |config|
        config.oauth_token = old_oauth_token
        config.oauth_token_expires_at = Time.now - 10
        config.api_key = api_key
        config.secret_api_key = secret_api_key
        config.username = username
        config.password = password
      end
    end

    # First we stub the authentication request, then we stub the original request
    # using the new oauth token from the authentication request.
    let!(:stubbed_authentication_request) do
      stub_request(:post, "https://api.kayzen.io/v1/authentication/token")
        .with(
          body: "{\"username\":\"fake_username\",\"password\":\"fake_password\",\"grant_type\":\"password\"}",
          headers: {
            "Authorization" => "Basic ZmFrZV9hcGlfa2V5OmZha2Vfc2VjcmV0X2FwaV9rZXk=",
            "Accept" => "application/json",
            "Content-Type" => "application/json",
            "Expect" => "",
            "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
          }
        )
        .to_return(mock_authentication_response)
    end
    let(:mock_authentication_response_body) do
      {
        "access_token" => new_oauth_token,
        "expires_in" => 3600,
        "scope" => ""
      }
    end
    let(:mock_authentication_response) { {status: 200, body: mock_authentication_response_body.to_json, headers: {}} }

    let!(:stubbed_fake_endpoint_request) do
      stub_request(:get, "https://api.kayzen.io/v1/fake_endpoint")
        .with(
          headers: {
            "Authorization" => "Bearer #{new_oauth_token}",
            "Accept" => "application/json",
            "Content-Type" => "application/json",
            "Expect" => "",
            "User-Agent" => "Typhoeus - https://github.com/typhoeus/typhoeus"
          }
        )
        .to_return(mock_fake_endpoint_response)
    end
    let(:mock_fake_endpoint_response) { {status: 200, body: mock_fake_endpoint_response_body.to_json, headers: {}} }
    let(:mock_fake_endpoint_response_body) { {"fake_response" => "fake_response"} }

    it "makes a new authentication request, saves the new oauth token and uses it to make the original request" do
      response = nil

      expect { response = KayzenApi::FakeEndpoint.get }
        .to change { KayzenApi::App.config.oauth_token }
        .from(old_oauth_token)
        .to(new_oauth_token)
        .and change { KayzenApi::App.config.oauth_token_expires_at }

      expect(stubbed_authentication_request).to have_been_requested
      expect(stubbed_fake_endpoint_request).to have_been_requested

      expect(response.success).to eq(true)
      expect(response.code).to eq(200)
      expect(response.body).to eq(mock_fake_endpoint_response_body)
    end
  end
end
