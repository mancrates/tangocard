module Tangocard
  class Reward < Base

    def active?
      status.downcase == 'active'
    end

    # Is this a variable-priced reward?
    #
    # Example:
    #   >> reward.variable_value?
    #    => true # reward is variable-priced
    #
    # Arguments:
    #   none
    def variable_value?
      value_type == 'VARIABLE_VALUE'
    end

    # Is this reward purchasable given a certain number of cents available to purchase it?
    # True if reward is available and user has enough cents
    # False if reward is unavailable OR user doesn't have enough cents
    #
    # Example:
    #   >> reward.purchasable?(500)
    #    => true # reward is available and costs <= 500 cents
    #
    # Arguments:
    #   balance_in_cents: (Integer)
    def purchasable?(balance_in_cents)
      return false unless active?

      if variable_price?
        min_price <= balance_in_cents
      else
        denomination <= balance_in_cents
      end
    end

    # Converts price in cents for given field to Money object using currency_code
    #
    # Example:
    #   >> reward.to_money(:unit_price)
    #    => #<Money fractional:5000 currency:USD>
    #
    # Arguments:
    #   field: (Symbol - must be :min_price, :max_price, or :denomination)
    def to_money(field)
      return nil unless %I[min_price max_price denomination].include?(field)

      Money.new(send(field), currency_code)
    end
  end
end
