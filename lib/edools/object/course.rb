require 'edools/resource/courses'

module Edools
  module Object
    class Course
      attr_accessor :data

      KEYS_UPDATE = %w[
        name description image_url duration code ready course_modules_ids
      ].freeze

      def initialize(settings, data)
        @settings = settings
        @data = data
      end

      def id
        @data['id']
      end

      def update
        @courses ||= Resource::Courses.new(@settings)
        @courses.update(self)
      end

      def data_to_update
        @data.select { |k, _| KEYS_UPDATE.include?(k) }
      end
    end
  end
end
