module Tangocard
  module Raas

    class ResponseException < StandardError; end
    class NotFoundException < StandardError; end
    class CacheException < StandardError; end

  end
end

require 'tangocard/raas'
require 'tangocard/raas/base'
require 'tangocard/raas/account'
require 'tangocard/raas/catalog'
require 'tangocard/raas/customer'
require 'tangocard/raas/order'
require 'tangocard/raas/exchange_rate'
