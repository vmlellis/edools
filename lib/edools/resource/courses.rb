require 'edools/object/course'

module Edools
  module Resource
    class Courses
      def initialize(settings, subdomain)
        @endpoint = '/api/courses'
        @settings = settings
        @request = Request.new(settings, subdomain)
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
    end
  end
end
