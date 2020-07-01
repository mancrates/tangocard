module Tangocard
  class Account < Base

    class << self
      def all
        Tangocard::Raas::Account.index.map { |r| new(r) }
      end

      # Find a account given an identifier.
      #
      # Example:
      #   >> Tangocard::Account.find('bonusly')
      #    => #<Tangocard::Account:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   identifier: (String)
      #
      def find_by_customer(customer_id)
        Tangocard::Raas::Customer.accounts_index(customer_id).map do |r|
          new(r)
        end
      end

      # Find a account given an identifier.
      #
      # Example:
      #   >> Tangocard::Account.find('bonusly')
      #    => #<Tangocard::Account:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   identifier: (String)
      #
      def find(identifier)
        new Tangocard::Raas::Account.show(identifier)
      end

      # Create a account given an identifier and display name (optional)
      #
      # Example:
      #   >> Tangocard::Account.create('bonusly', 'test')
      #    => #<Tangocard::Account:0x007f9a6fec0138 ... >
      #
      # Arguments:
      #   display_name: (String)
      #   identifier: (String)
      #
      def create(customer_id, display_name, email, account_id = nil)
        new Tangocard::Raas::Customer.account_create(
          customer_id,
          account_identifier: (account_id || display_name).parameterize('_'),
          contact_email: email,
          display_name: display_name
        )
      end

      # Find account, or create if account not found.
      #
      # Example:
      #   >> Tangocard::Account.find_or_create('bonusly')
      #    => #<Tangocard::Account:0x007f9a6fec0138 ... >
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

    def active?
      status.downcase == 'active'
    end

















    
    # Register a credit card
    # Raises Tango::AccountRegisterCreditCardFailedException on failure.
    # Example:
    #   >> account.register_credit_card('128.128.128.128', Hash (see example below))
    #    => #<Tangocard::Response:0x007f9a6fec0138 ...>
    #
    # Arguments:
    #   client_ip: (String)
    #   credit_card: (Hash) - see
    # https://www.tangocard.com/docs/raas-api/#create-cc-registration for details
    #
    # Credit Card Hash Example:
    #
    #   {
    #       'number' => '4111111111111111',
    #       'expiration' => '2017-01',
    #       'security_code' => '123',
    #       'billing_address' => {
    #           'f_name' => 'Jane',
    #           'l_name' => 'User',
    #           'address' => '123 Main Street',
    #           'city' => 'Anytown',
    #           'state' => 'NY',
    #           'zip' => '11222',
    #           'country' => 'USA',
    #           'email' => 'jane@company.com'
    #       }
    #   }
    def register_credit_card(client_ip, credit_card)
      Tangocard::Raas::Fund.register_credit_card(
        client_ip: client_ip,
        credit_card: credit_card,
        customer: customer,
        account_identifier: identifier
      )
    end

    # Add funds to the account.
    # Raises Tangocard::AccountFundFailedException on failure.
    # Example:
    #   >> account.cc_fund(5000, '128.128.128.128', '12345678', '123')
    #    => #<Tangocard::Response:0x007f9a6fec0138 ...>

    # Arguments:
    #   amount: (Integer)
    #   client_ip: (String)
    #   cc_token: (String)
    #   security_code: (String)
    # 
    #   params = {
    #       'amount' => amount,
    #       'client_ip' => client_ip,
    #       'cc_token' => cc_token,
    #       'customer' => customer,
    #       'account_identifier' => identifier,
    #       'security_code' => security_code
    #   }
    #
    #   response = Tangocard::Raas.cc_fund_account(params)
    # end
    #
    def cc_fund(amount, client_ip, cc_token, security_code)
      Tangocard::Raas::Fund.cc_fund_account(
        amount: amount,
        client_ip: client_ip,
        cc_token: cc_token,
        customer: customer,
        account_identifier: identifier,
        security_code: security_code
      )
    end

    # Delete a credit card from an account
    # Raises Tangocard::AccountDeleteCreditCardFailedException failure.
    # Example:
    #   >> account.delete_credit_card("12345678")
    #    => #<Tangocard::Response:0x007f9a6fec0138 ...>

    # Arguments:
    #   cc_token: (String)
    def delete_credit_card(cc_token)
      params = {
        'cc_token' => cc_token,
        'customer' => customer,
        'account_identifier' => identifier
      }

      Tangocard::Raas::Fund.credit_card_delete(params)
    end

  end
end
