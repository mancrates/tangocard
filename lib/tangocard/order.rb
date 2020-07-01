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

    def claim_code
      reward[:credentials][:claim_code]
    end
  end
end
