module Tangocard
  class Catalog < Base

    class << self
      def instance
        new Tangocard::Raas::Catalog.index
      end
    end

    def name
      catalog_name
    end

    def brands
      @brands ||= attributes[:brands]&.map { |r| Brand.new(r) }
    end
  end
end
