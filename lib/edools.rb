require 'edools/version'
require 'edools/client'
require 'edools/request'

module Edools
  class << self
    def client
      @client ||= Client.new
    end

    def method_missing(method, *args, &block)
      super unless respond_to_missing?(method)
      client.send(method, *args)
    end

    def respond_to_missing?(method, include_private = false)
      client.respond_to?(method) || super
    end
  end
end
