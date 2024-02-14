module KayzenApi
  class OauthToken < Dry::Struct
    attribute :token?, Types::String
    attribute :expires_at, Types::Time

    def valid?
      token.present? && !expired_or_expires_soon?
    end

    def expired_or_expires_soon?
      (Time.now - 1.minute) > expires_at
    end
  end
end
