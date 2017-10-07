require 'oj'

module Edools
  module Resource
    # Resource to media
    class Media
      def initialize(settings)
        @endpoint = '/api/media'
        @settings = settings
        @request = Request.new(settings)
      end

      def get(id)
        response = @request.get("#{@endpoint}/#{id}")
        Oj.load(response.body)
      end
    end
  end
end
