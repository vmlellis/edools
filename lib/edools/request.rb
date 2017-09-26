require 'faraday'
require 'faraday_middleware'
require 'typhoeus/adapters/faraday'
require 'oj'

module Edools
  class Request
    METHODS = %i[get post put delete].freeze

    def initialize(token, school = nil)
      subdomain = school || 'core'
      url = "https://#{subdomain}.myedools.info/"
      @conn = Faraday.new(url: url) do |faraday|
        faraday.request :url_encoded
        faraday.response :json, content_type: 'application/json'
        faraday.adapter :typhoeus
      end
      @conn.authorization :Token, token: token
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
      response = @conn.send(method) do |req|
        req.url endpoint, params
      end
      body = response.body
      Oj.load(body)
    end
  end
end
