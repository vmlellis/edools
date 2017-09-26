require 'edools/object/student'

module Edools
  module Resource
    class Students
      def initialize(settings, subdomain)
        @endpoint = '/api/students'
        @settings = settings
        @request = Request.new(settings, subdomain)
      end

      def all(opts = {})
        response = @request.get(@endpoint)
        data = Oj.load(response.body)
        data['students'].map! do |course|
          Object::Student.new(@settings, course)
        end
        data
      end

      def create(first_name, email, password, extra = {})
        opts = extra.merge(
          first_name: first_name, email: email,
          password: password, password_confirmation: password
        )
        response = @request.post(@endpoint, user: opts)
        data = Oj.load(response.body)
        Object::Student.new(@settings, data)
      end

      def find(id)
        response = @request.get("#{@endpoint}/#{id}")
        data = Oj.load(response.body)
        Object::Student.new(@settings, data)
      end
    end
  end
end
