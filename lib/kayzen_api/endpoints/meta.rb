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

    class SiteObjects < Endpoint
      path "meta/site_objects"
    end

    class AppObjects < Endpoint
      path "meta/app_objects"
    end
  end
end
