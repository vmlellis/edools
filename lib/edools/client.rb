require 'edools/resource/schools'

module Edools
  class Client
    attr_accessor :token

    def initialize(opts = {})
      @token = opts[:token]
    end

    def schools
      @schools ||= Resource::Schools.new(token)
    end
  end
end
