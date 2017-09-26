require 'edools/object/school'
require 'oj'

module Edools
  module Resource
    class Schools
      def initialize(settings)
        @endpoint = '/schools'
        @settings = settings
        @request = Request.new(settings)
      end

      def all(opts = {})
        response = @request.get(@endpoint, opts)
        data = Oj.load(response.body)
        data['schools'].map! { |school| Object::School.new(@settings, school) }
        data
      end

      def create(name, email, password)
        opts = { name: name, email: email, password: password }
        response = @request.post("#{@endpoint}/wizard", school: opts)
        data = Oj.load(response.body)
        Object::School.new(@settings, data['school'])
      end

      def find(id)
        response = @request.get("#{@endpoint}/#{id}")
        data = Oj.load(response.body)
        Object::School.new(@settings, data)
      end
    end
  end
end
