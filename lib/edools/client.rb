require 'edools/settings'
require 'edools/resource/schools'

module Edools
  class Client
    attr_accessor :settings

    def initialize(opts = {})
      @settings = Settings.new(opts)
    end

    def schools
      @schools ||= Resource::Schools.new(@settings)
    end
  end
end
