module Tangocard
  class Brand < Base

    class << self
      # Return an array of all brands.
      #
      # Example:
      #   >> Tangocard::Brand.all
      #    => [#<Tangocard::Brand:0x007f9a6f9d3030 ... >, ...]
      #
      # Arguments:
      #   none
      def all
        Catalog.instance.brands
      end

      # Return an array of default brands. You can set :default_brands in your
      # Tangocard initializer to define your desired list of brands. See the
      # README for details.
      #
      # Example:
      #   >> Tangocard::Brand.default
      #    => [#<Tangocard::Brand:0x007f9a6f9d3030 ... >, ...]
      #
      # Arguments:
      #   none
      def default
        all.select do |b|
          Tangocard.configuration.default_brands.include?(b.brand_name)
        end
      end

      # Find a brand by its :description field.
      #
      # Example:
      #   >> Tangocard::Brand.find("Amazon.com")
      #    => #<Tangocard::Brand:0x007f96a9cbe980 ... >]>
      #
      # Arguments:
      #   brand_name: (String)
      def find(brand_name)
        all.select { |b| b.brand_name == brand_name }.first
      end
    end

    def rewards
      @rewards ||= (attributes[:items] || []).map { |r| Reward.new(r) }
    end

    # brands only have a single variable reward
    def variable_reward
      rewards.select(&:active?).select(&:variable_value?).first
    end

    def fixed_rewards
      rewards.select(&:active?).select(&:fixed_value?)
    end

    def redemption_instructions
      rewards.select(&:active?).first.redemption_instructions
    end

    # Return the image_url for the brand.  For some brands, there is no image_url. You can set :local_images in your
    # Tangocard initializer to provide a local image for a specified brand.  See the README for details.
    #
    # Example:
    #   >> amazon_brand.image_url
    #    => "http://static-integration.tangocard.com/graphics/item-images/amazon-gift-card.png"
    #
    # Arguments:
    #   none
    def image_url
      Tangocard.configuration.local_images[description] || @image_url
    end

    # Return the rewards that are purchasable given a balance (in cents).
    #
    # Example:
    #   >> itunes_brand.purchasable_rewards(1000)
    #    => [#<Tangocard::Reward:0x007f96aa3b4dc0 @type="reward", @description="iTunes Code USD $5",
    #        @sku="APPL-E-500-STD", @is_variable=false, @denomination=500, @min_price=0, @max_price=0,
    #        @currency_code="USD", @available=true, @countries=["US"]>,
    #        #<Tangocard::Reward:0x007f96aa3b4d98 @type="reward", @description="iTunes Code USD $10",
    #        @sku="APPL-E-1000-STD", @is_variable=false, @denomination=1000, @min_price=0, @max_price=0,
    #        @currency_code="USD", @available=true, @countries=["US"]>]
    #
    # Arguments:
    #   balance_in_cents: (Integer)
    def purchasable_rewards(balance_in_cents)
      rewards.select do |r|
        r.purchasable?(balance_in_cents) &&
          !Tangocard.configuration.sku_blacklist.include?(r.sku)
      end
    end

    # True if there are any purchasable rewards given a balance in cents, false otherwise.
    #
    # Example:
    #   >> itunes_brand.purchasable_rewards?(1000)
    #    => true
    #
    # Arguments:
    #   balance_in_cents: (Integer)
    def purchasable_rewards?(balance_in_cents)
      purchasable_rewards(balance_in_cents).any?
    end

    # True if this is a brand with variable-price rewards.
    #
    # Example:
    #   >> itunes_brand.variable_price?
    #    => false
    #   >> amazon_brand.variable_price?
    #    => true
    #
    # Arguments:
    #   none
    def variable_price?
      rewards.select(&:variable_price?).any?
    end

    # True if this is a brand with fixed-price rewards.
    #
    # Example:
    #   >> itunes_brand.fixed_price?
    #    => false
    #   >> amazon_brand.fixed_price?
    #    => true
    #
    # Arguments:
    #   none
    def fixed_price?
      rewards.select(&:fixed_price?).any?
    end
  end
end
