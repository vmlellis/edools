require 'edools/object/course'

module Edools
  module Resource
    # Resource to school courses
    class Courses
      def initialize(settings)
        @endpoint = '/api/courses'
        @settings = settings
        @request = Request.new(settings)
      end

      def all
        response = @request.get(@endpoint)
        data = Oj.load(response.body)
        data['courses'].map! { |course| Object::Course.new(@settings, course) }
        data
        end

      def create(name, extra = {})
        opts = extra.merge(name: name)
        response = @request.post(@endpoint, course: opts)
        data = Oj.load(response.body)
        Object::Course.new(@settings, data)
      end

      def find(id)
        response = @request.get("#{@endpoint}/#{id}")
        data = Oj.load(response.body)
        Object::Course.new(@settings, data)
      end

      def update(course)
        opts = { course: course.data_to_update }
        response = @request.put("#{@endpoint}/#{course.id}", opts)
        raise 'Course not updated' if response.status != 204
      end
    end
  end
end
