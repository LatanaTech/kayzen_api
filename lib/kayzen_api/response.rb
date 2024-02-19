module KayzenApi
  class Response < Dry::Struct
    attribute :success, Types::Bool
    attribute :code, Types::Integer
    attribute :body, Types::Array.of(Types::Hash) | Types::Hash
  end
end
