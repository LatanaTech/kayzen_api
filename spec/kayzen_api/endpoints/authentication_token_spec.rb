require "spec_helper"

RSpec.describe KayzenApi::AuthenticationToken do
  subject(:authentication_token) { described_class }

  it "make a post request" do
    authentication_token.create(body_params: { username: "username", password: "password", grant_type: "password" })
  end
end
