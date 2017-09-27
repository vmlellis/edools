require 'edools/resource/students'

module Edools
  module Object
    # Student Object
    class Student
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
        @students ||= Resource::Students.new(@settings)
        @students.update(self)
      end

      def data_to_update
        @data.select { |k, _| KEYS_UPDATE.include?(k) }
      end
    end
  end
end
