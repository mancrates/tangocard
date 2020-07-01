module Tangocard
  class Base

    attr_reader :attributes

    class << self
      def first
        all.first
      end
    end

    def initialize(attributes)
      @attributes = attributes.deep_transform_keys!(&:to_sym)
    end

    def method_missing(method, *args)
      method_name = find_method(method)

      super unless method_name

      case attributes[method_name]
      when /^\d+$/ then attributes[method_name].to_i
      when /^\d+.\d+$/ then attributes[method_name].to_f
      else attributes[method_name]
      end
    end

    def respond_to_missing?(method, *)
      attributes.key?(method) || super
    end

    private

    def find_method(method)
      [method, prefixed_method(method)].detect do |key|
        attributes.key?(key)
      end
    end

    def prefixed_method(method)
      [self.class.name.demodulize.underscore, method].join('_').to_sym
    end
  end
end
