module Edools
  module Resource
    class Courses
      def initialize(request)
        endpoint = '/courses'
        klass = ::Edools::Object::Course
        @resource = MainResource.new(request, endpoint, klass)
      end

      def all
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
