module Tangocard
  module Raas
    class Fund < Base
      class << self

        #### Deposits

        # Funds an account. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Fund.credit_card_deposit_create(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params:
        def credit_card_deposit_create(params)
          post_request('/creditCardDeposits', params)
        end

        # Gets credit card deposit details. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Fund.credit_card_deposit_show(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   deposit_id: string
        #
        def credit_card_deposit_show(deposit_id)
          get_request("/creditCardDeposits/#{deposit_id}")
        end

        #### Credit Cards

        # Gets a list of credit cards. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Fund.credit_card_index
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        def credit_card_index
          get_request('/creditCards')
        end

        # Gets credit card details. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Fund.credit_card_show(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   token: string
        #
        def credit_card_show(token)
          get_request("/creditCards/#{token}")
        end
 
        # Registers a credit card to an account. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas.credit_card_create(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params: 
        def credit_card_create(params)
          post_request('/creditCards', params)
        end

        # Deletes a credit card from an account. Returns Tangocard::Response.
        #
        # Example:
        #   >> Tangocard::Raas.credit_card_delete(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params: 
        def credit_card_delete(params)
          post_request('/creditCardUnregisters', params)
        end
      end
    end
  end
end