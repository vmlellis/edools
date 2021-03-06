require 'edools/resource/students'
require 'edools/resource/enrollments'

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

      def registered_school_product_id?(school_product_id)
        school_registration['enrollments'].each do |enrollment|
          product = enrollment['school_product']
          next unless product
          return true if school_product_id == product['id']
        end
        false
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

      def enrollment_school_product(school_product_id)
        @enrollments ||= Resource::Enrollments.new(@settings)
        @enrollments.create(school_registration_id, school_product_id)
      end
    end
  end
end
