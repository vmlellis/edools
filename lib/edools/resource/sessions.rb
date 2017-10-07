require 'oj'

module Edools
  module Resource
    # Resource to sessions
    class Sessions
      def initialize(settings)
        @endpoint = '/api/users/sign_in'
        @settings = settings
        @request = Request.new(settings)
      end

      def create(email, password)
        raise 'settings.School_id must be declared' unless @settings.school_id
        opts = session_opts(email, password)
        response = @request.post(@endpoint, opts)
        Oj.load(response.body)
      end

      private

      def session_opts(email, password)
        {
          user: { email: email, password: password },
          realm: { type: 'School', id: @settings.school_id }
        }
      end
    end
  end
end
