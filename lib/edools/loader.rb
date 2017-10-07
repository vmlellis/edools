require 'edools/loader/csv'

module Edools
  # Loader
  class Loader
    def initialize(settings)
      @settings = settings
    end

    def csv(path, opts = {})
      @csv ||= Loader::Csv.new(@settings, path, opts)
    end
  end
end
