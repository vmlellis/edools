require 'oj'

module Edools
  module Resource
    # Resource to enrollments
    class Enrollments
      def initialize(settings, opts)
        @endpoint = '/api/enrollments'
        @settings = settings
        @request = Request.new(settings)
      end

      def all(opts = {})
        endpoint = '/api'
        endpoint << "/students/#{opts[:student_id]}" if opts[:student_id]
        if opts[:school_product_id]
          endpoint << "/school_products/#{opts[:school_product_id]}"
        end
        response = @request.get("#{endpoint}/enrollments")
        Oj.load(response.body)
      end

      def create(registration_id, school_product_id)
        opts = {
          registration_id: registration_id,
          school_product_id: school_product_id,
          max_attendance_type: 'indeterminate'
        }
        response = @request.post(@endpoint, opts)
        Oj.load(response.body)
      end
    end
  end
end
