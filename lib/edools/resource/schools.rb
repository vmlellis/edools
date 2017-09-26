module Edools
  module Resource
    class Schools
      def initialize(token)
        @token = token
        @request = Request.new(@token)
        @endpoint = '/schools'
      end

      def all
        @request.get(@endpoint)
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
