require 'faraday'
require 'faraday_middleware'
require 'typhoeus/adapters/faraday'

module Edools
  class Request
    METHODS = %i[get post patch put delete].freeze

    def initialize(settings, subdomain = nil)
      @conn = Faraday.new(url: settings.url) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.response :json, content_type: 'application/json'
        faraday.adapter :typhoeus
      end
      @conn.authorization(:Token, token: settings.token) if settings.token
      @headers = { accept: 'application/vnd.edools.core.v1+json' }
    end

    def method_missing(method, *args, &block)
      super unless respond_to_missing?(method)
      make_request(method, args[0], args[1])
    end

    def respond_to_missing?(method, include_private = false)
      METHODS.include?(method.to_sym) || super
    end

    private

    def make_request(method, endpoint, params = {})
      @conn.send(method, endpoint, params, @headers)
    end
  end
end
