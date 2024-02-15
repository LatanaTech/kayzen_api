module KayzenApi
  class Response < Dry::Struct
    attribute :success, Types::Bool
    attribute :code, Types::Integer
    attribute :body?, Types::Hash
  end
end
