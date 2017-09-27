require 'edools/object/school'
require 'oj'

module Edools
  module Resource
    # Resource to schools
    class Schools
      def initialize(settings)
        @endpoint = '/api/schools'
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
        return data if data.key?('errors')
        {
          credentials: data['admin']['credentials'],
          school_id: data['school']['id']
        }
      end

      def get
        find(@settings.school_id)
      end

      def find(id)
        response = @request.get("#{@endpoint}/#{id}")
        data = Oj.load(response.body)
        Object::School.new(@settings, data)
      end

      def update(school)
        opts = { school: school.data_to_update }
        response = @request.put("#{@endpoint}/#{school.id}", opts)
        raise 'School not updated' if response.status != 204
      end
    end
  end
end
