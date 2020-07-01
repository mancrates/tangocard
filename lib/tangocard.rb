require 'httparty'
require 'money'
require 'ostruct'
require 'active_support'
require 'active_support/cache/memory_store'
require 'tangocard/version'

module Tangocard

  CACHE_PREFIX = "tangocard:#{VERSION}:"

  class Configuration
    attr_accessor :name, :key, :base_uri, :default_brands, :local_images, :sku_blacklist,
                  :use_cache, :cache, :logger

    def initialize
      self.name = nil
      self.key = nil
      self.base_uri = 'https://sandbox.tangocard.com'
      self.default_brands = []
      self.local_images = {}
      self.sku_blacklist = []
      self.use_cache = true
      self.cache = ActiveSupport::Cache::MemoryStore.new
      self.logger = Logger.new(STDOUT)
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
    warm_cache if configuration.use_cache
  end

  def self.warm_cache
    configuration.cache.write(
      "#{Tangocard::CACHE_PREFIX}catalog", 
      Tangocard::Raas::Catalog.index(use_cache: false)
    )

    configuration.logger.info('Warmed Tangocard cache')
  end
end

require 'tangocard/response'
require 'tangocard/raas'
require 'tangocard/base'
require 'tangocard/account'
require 'tangocard/brand'
require 'tangocard/catalog'
require 'tangocard/customer'
require 'tangocard/order'
require 'tangocard/reward'
require 'tangocard/exchange_rate'
