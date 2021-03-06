module Tangocard
  class Order < Base
    class << self
      # Return an array of all orders.
      #
      # Example:
      #   >> Tangocard::Order.all
      #    => [#<Tangocard::Order:0x007f9a6c4bca68 ...>, ...]
      #
      # Arguments:
      #   params:
      #
      def all
        Tangocard::Raas::Order.index.map { |r| new(r) }
      end

      # Find a list of Orders given the criteria.
      #
      # Example:
      #   >> Tangocard::Order.find_by(external_ref_id: 1234)
      #    => #<Tangocard::Order:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   external_ref_id: (String)
      #
      def find_by(params)
        response = Tangocard::Raas::Order.index(params)
        order = (response['orders'] || []).first
        find(order['reference_order_id']) if order && order['reference_order_id']
      end

      # Find a Order given an order_id.
      #
      # Example:
      #   >> Tangocard::Order.find(12324)
      #    => #<Tangocard::Order:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   order_id: (String)
      #
      def find(order_id)
        new Tangocard::Raas::Order.show(order_id)
      end

      # Create an order
      #
      # Example:
      #   >> Tangocard::Account.create('bonusly', 'test')
      #    => #<Tangocard::Account:0x007f9a6fec0138 ... >
      #
      # Example:
      #   >> Tangocard::Order.create(params)
      #    => #<Tangocard::Order:0x007f9a6c4bca68 ...>
      #
      def create(params)
        new Tangocard::Raas::Order.create(params)
      end
    end

    def card_number
      reward[:credentials][:claim_code] || reward[:credentials][:card_number]
    end

    def pin
      reward[:credentials][:pin]
    end

    def redemption_url
      reward[:credentials][:redemption_url] || reward[:credentials][:bypass_url]
    end
  end
end
