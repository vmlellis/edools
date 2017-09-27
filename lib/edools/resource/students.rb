require 'edools/object/student'

module Edools
  module Resource
    # Resource to students
    class Students
      def initialize(settings)
        @endpoint = '/api/students'
        @settings = settings
        @request = Request.new(settings)
      end

      def all(opts = {})
        response = @request.get(@endpoint, opts)
        data = Oj.load(response.body)
        data['students'].map! do |student|
          Object::Student.new(@settings, student)
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

      def update(student)
        opts = { user: student.data_to_update }
        response = @request.put("#{@endpoint}/#{student.id}", opts)
        raise 'Student not updated' if response.status != 204
      end
    end
  end
end
