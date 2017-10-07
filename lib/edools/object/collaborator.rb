require 'edools/resource/collaborators'
require 'edools/resource/enrollments'

module Edools
  module Object
    # Collaborator Object
    class Collaborator
      attr_accessor :data

      KEYS_UPDATE = %w[
        first_name email password password_confirmation last_name username
        cpf rg phone extra_phone skype twitter facebook company_name
        company_position born_at biography cover_image_url created_at
        last_sign_in_at role_ids address_attributes
      ].freeze

      def initialize(settings, data)
        @settings = settings
        @data = data
      end

      def id
        @data['id']
      end

      def update
        @collaborators ||= Resource::Collaborators.new(@settings)
        @collaborators.update(self)
      end

      def data_to_update
        @data.select { |k, _| KEYS_UPDATE.include?(k) }
      end

      def school_registration_id
        school_registration['id']
      end

      def school_registration
        @school_registration ||= begin
          @data['registrations'].each do |registration|
            if registration['school_id'] == @settings.school_id
              return registration
            end
          end
          {}
        end
      end
    end
  end
end
