RSpec.describe KayzenApi::App do
  subject(:app) { described_class }

  describe "config" do
    it "contains all the config options" do
      expect(app.config.to_h.keys)
        .to match_array(%i[base_url oauth_token oauth_token_expires_at username password api_key secret_api_key logger])
    end

    it "sets the correct default values" do
      expect(app.config.base_url).to eq "https://api.kayzen.io/v1/"

      expect(app.config.oauth_token).to eq nil
      expect(app.config.oauth_token_expires_at).to eq nil
      expect(app.config.username).to eq nil
      expect(app.config.password).to eq nil
      expect(app.config.api_key).to eq nil
      expect(app.config.secret_api_key).to eq nil
      expect(app.config.logger).to eq nil
    end
  end
end
