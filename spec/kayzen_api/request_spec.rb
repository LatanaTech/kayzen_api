RSpec.describe KayzenApi::Request do
  class KayzenApi::FakeEndpoint < KayzenApi::Endpoint
  end

  context 'when the oauth token is present and not about to expire' do
    let(:oauth_token) { 'fake_oauth_token' }

    before do
      KayzenApi::App.configure do |config|
        config.oauth_token = oauth_token
        config.oauth_token_expires_at = Time.now + 3600
        # config.api_key = api_key
        # config.secret_api_key = secret_api_key
        # config.username = username
        # config.password = password
      end
    end

    context 'when the request succeeds' do
      it 'returns a success response' do
      end
    end

    context 'when the request fails' do
      it 'returns an error response' do
      end
    end
  end

  context 'when the oauth token is about to expire' do
  end
end
