require 'edools/resource/students'

module Edools
  module Object
    # School Product Object
    class SchoolProduct
      attr_accessor :data

      KEYS_UPDATE = %w[
        title description subtitle logo video_url video_title video_description
        published hidden restricted certification classes_auto_generation
        certification_min_progress meta_title meta_description meta_keys
        available_time_type available_time_length available_time_unit
        expire_date library_resource_id max_attendance_type
        max_attendance_length allowed_emails class_teacher_ids
        category_ids gallery_media_ids
      ].freeze

      def initialize(settings, data)
        @settings = settings
        @data = data
      end

      def id
        @data['id']
      end

      def update
        request = Edools::Request.new(@settings)
        opts = { school: data_to_update }
        response = request.put("/schools/#{@data['id']}", opts)
        raise 'Object not update' if response.status != 204
      end

      def students
        @students ||= Resource::Students.new(@settings)
        @students.all(school_product_id: id)
      end
    end
  end
end
