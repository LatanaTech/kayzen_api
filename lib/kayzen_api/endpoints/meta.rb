module KayzenApi
  module Meta
    class Exchanges < Endpoint
      path "meta/exchanges"
    end

    class Countries < Endpoint
      path "meta/countries"
    end

    class States < Endpoint
      path "meta/states"
    end

    class Cities < Endpoint
      path "meta/cities"
    end

    class Timezones < Endpoint
      path "meta/time_zones"
    end
  end
end
