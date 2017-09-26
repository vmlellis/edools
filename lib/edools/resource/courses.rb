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
        response.body
        # TODO
      end

      def create(obj)
        # TODO
      end

      def update(obj)
        # TODO
      end

      def find(id)
        # TODO
      end
    end
  end
end
