module Tangocard
  module Raas
    class Order < Base
      class << self
        # Retrieve a list of historical orders. Returns Tangocard::Response.
        #
        # Example:
        #   >> Tangocard::Raas::Order.index
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params:
        def index(params = {})
          query_string = ''

          if params.any?
            query_string = '?'
            params.keys.each_with_index do |k, i|
              query_string += '&' unless i.zero?
              key = k.to_s.camelize(:lower)
              key.sub!(/Id$/,'ID') if key.match(/Id$/)
              query_string += "#{key}=#{params[k]}"
            end
          end

          get_request("/orders#{query_string}")
        end

        # Get order details. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Order.show(order_id)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params:
        def show(order_id)
          get_request("/orders/#{order_id}")
        end

        # Create an order. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Order.create(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params:
        def create(params)
          post_request('/orders', params)
        end
      end
    end
  end
end
