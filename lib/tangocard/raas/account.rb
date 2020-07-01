module Tangocard
  module Raas
    class Account < Base
      class << self
        # Gets a list of accounts. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Account.index
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        def index
          get_request('/accounts')
        end

        # Gets account details. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Account.show(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   account_identifier: string
        #
        def show(account_identifier)
          get_request("/accounts/#{account_identifier}")
        end

        # Create a new account. Returns Tangocard::Response object.
        #
        # Example:
        #   >> Tangocard::Raas::Account.create(params)
        #    => #<Tangocard::Response:0x007f9a6c4bca68 ...>
        #
        # Arguments:
        #   params: 
        def create(params)
          post_request('/accounts', params)
        end
      end
    end
  end
end