module Tangocard
  module Raas
    class Customer < Base
      class << self
        # Gets a list of customers. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Customer.index
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Response:
        # [
        #   {
        #     "accounts": [
        #       {
        #         "accountIdentifier": "string",
        #         "accountNumber": "string",
        #         "createdAt": "string",
        #         "displayName": "string",
        #         "status": "string"
        #       }
        #     ],
        #     "createdAt": "string",
        #     "customerIdentifier": "string",
        #     "displayName": "string",
        #     "status": "string"
        #   }
        # ]
        #
        def index
          get_request('/customers')
        end

        # Create a new customer. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Customer.create(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params: {
        #     "identifier": "string",
        #     "display_name": "string"
        #   }
        #
        # Response:
        # {
        #   "createdAt": "string",
        #   "customerIdentifier": "string",
        #   "displayName": "string",
        #   "status": "string"
        # }
        #
        def create(params)
          post_request('/customers', params)
        end

        # Gets customer details. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Customer.show(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   identifier: 'string'
        #
        def show(identifier)
          get_request("/customers/#{identifier}")
        end

        # Gets a list of a customers accounts. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Customer.account_index(identifier)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params: {
        #     identifier: 'string'
        #   }
        #
        # Response:
        # [
        #   {
        #     "accountIdentifier": "string",
        #     "accountNumber": "string",
        #     "createdAt": "string",
        #     "displayName": "string",
        #     "status": "string"
        #   }
        # ]
        #
        def accounts_index(identifier)
          get_request("/customers/#{identifier}/accounts")
        end

        # Create a new customer account. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Customer.account_create(customer_id, params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   identifier: "string"
        #   params: {
        #     "account_identifier": "string",
        #     "contact_email": "string",
        #     "display_name": "string"
        #   }
        #
        # Response:
        # {
        #   "accountIdentifier": "string",
        #   "accountNumber": "string",
        #   "contactEmail": "string",
        #   "createdAt": "string",
        #   "currencyCode": "string",
        #   "currentBalance": 0,
        #   "displayName": "string",
        #   "status": "string"
        # }
        #
        def account_create(identifier, params)
          post_request(
            "/customers/#{identifier}/accounts", params
          )
        end
      end
    end
  end
end
