module Edools
  module Object
    class Course
      attr_accessor :data

      def initialize(settings, data)
        @settings = settings
        @data = data
      end
    end
  end
end
