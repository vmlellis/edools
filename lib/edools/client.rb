require 'edools/settings'
require 'edools/resource/schools'
require 'edools/resource/students'
require 'edools/resource/collaborators'
require 'edools/resource/sessions'
require 'edools/resource/media'

module Edools
  # Client
  class Client
    attr_accessor :settings

    def initialize(opts = {})
      @settings = Settings.new(opts)
    end

    def schools
      Resource::Schools.new(@settings)
    end

    def students
      Resource::Students.new(@settings)
    end

    def collaborators
      Resource::Collaborators.new(@settings)
    end

    def sessions
      Resource::Sessions.new(@settings)
    end

    def media
      Resource::Media.new(@settings)
    end

    def loader
      Loader.new(@settings)
    end
  end
end
