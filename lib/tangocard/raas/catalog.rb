module Tangocard
  module Raas
    class Catalog < Base
      class << self
        # Get all items in the Catalog. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas.catalog
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   none
        #
        def index(use_cache: true)
          unless Tangocard.configuration.use_cache && use_cache
            return get_request('/catalogs')
          end

          cached_response = Tangocard.configuration.cache
                                     .read("#{Tangocard::CACHE_PREFIX}catalog")

          if cached_response.nil?
            raise CacheException, 'Tangocard cache is not primed.'
          end

          cached_response
        end
      end
    end
  end
end