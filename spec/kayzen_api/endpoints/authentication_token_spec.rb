require "spec_helper"

RSpec.describe KayzenApi::AuthenticationToken do
  subject(:authentication_token) { described_class }
  let(:headers) { { "Content-Type" => "application/json" } }

  before do
  end

  after do
    Typhoeus::Expectation.clear
  end

  it "make a post request" do
    response_body =
      {
        "access_token": "some_token",
        "expires_in": "1799",
        "scope": ""
      }
    stubbed_response = Typhoeus::Response.new(code: 200, body: response_body)

    Typhoeus
      .stub('https://api.kayzen.io/v1/authentication/token')
      .and_return(stubbed_response) do |request|
        expect(request.method).to eq :get
        expect(request.options[:headers]).to eq "lksajdf"
      end

    body_params = { username: "username", password: "secret", grant_type: "password" }
    response = authentication_token.create(body_params: body_params)
    expect(response).to eq(stubbed_response)
  end
end
