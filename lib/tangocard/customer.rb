module Tangocard
  class Customer < Base

    class << self
      def all
        Tangocard::Raas::Customer.index.map { |p| new(p) }
      end

      # Find a customer given an id.
      #
      # Example:
      #   >> Tangocard::Customer.find('bonusly')
      #    => #<Tangocard::Customer:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   id: (String)
      #
      def find(identifier)
        new Tangocard::Raas::Customer.show(identifier)
      end

      # Create a customer given an identifier and display name (optional)
      #
      # Example:
      #   >> Tangocard::Customer.create('bonusly', 'test')
      #    => #<Tangocard::Customer:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   display_name: (String)
      #   identifier: (String)
      #
      def create(display_name, identifier = nil)
        new Tangocard::Raas::Customer.create(
          customer_identifier: (identifier || display_name).parameterize('_'),
          display_name: display_name
        )
      end

      # Find customer, or create if customer not found.
      #
      # Example:
      #   >> Tangocard::Customer.find_or_create('bonusly')
      #    => #<Tangocard::Customer:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   identifier: (String)
      #
      def find_or_create(identifier)
        find(identifier)
      rescue Tangocard::Raas::NotFoundException
        create(identifier)
      end
    end

    def accounts
      @accounts ||= (attributes[:accounts] || []).map { |r| Account.new(r) }
    end

    def active?
      status.downcase == 'active'
    end
  end
end
