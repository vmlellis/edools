require 'edools/object/collaborator'

module Edools
  module Resource
    # Resource to collaborators
    class Collaborators
      def initialize(settings)
        @endpoint = '/api/collaborators'
        @settings = settings
        @request = Request.new(settings)
      end

      def all(opts = {})
        response = @request.get(@endpoint, opts)
        data = Oj.load(response.body)
        data['collaborators'].map! do |collaborator|
          Object::Collaborator.new(@settings, collaborator)
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
        Object::Collaborator.new(@settings, data)
      end

      def find(id)
        response = @request.get("#{@endpoint}/#{id}")
        data = Oj.load(response.body)
        Object::Collaborator.new(@settings, data)
      end

      def update(collaborator)
        opts = { user: collaborator.data_to_update }
        response = @request.put("#{@endpoint}/#{collaborator.id}", opts)
        raise 'Colaborator not updated' if response.status != 204
      end
    end
  end
end
