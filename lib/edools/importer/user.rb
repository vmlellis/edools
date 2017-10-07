require 'edools/resource/students'
require 'edools/resource/collaborators'

module Edools
  module Importer
    # Import a user
    class User
      def initialize(settings, opts = {})
        raise 'no settings' if settings.nil?
        @first_name = opts[:first_name]
        @email = opts[:email]
        @type = opts[:type]
        @school_product_id = opts[:school_product_id]
        @students = Resource::Students.new(settings)
        @collaborators = Resource::Collaborators.new(settings)
      end

      def import
        return import_collaborator if @type == 'Collaborator'
        import_student
      end

      private

      def import_student
        student = load_student
        if student.nil?
          student =  @students.create(@first_name, @email, '123456')
          if student.data['errors']
            student.data['errors'].each do |k, v|
              puts "[ERRO] #{@email}: #{k} #{v}"
            end
          end
          student = load_student
          return if student.nil?
        else
          return if @school_product_id.zero?
          return if student.registered_school_product_id?(@school_product_id)
        end
        student.enrollment_school_product(@school_product_id)
      end

      def import_collaborator
        colllaborator = load_collaborator
        if colllaborator.nil?
          @collaborators.create(@first_name, @email, '123456')
        end
      end

      def load_student
        @students.all(full_name: @email)['students'].first
      end

      def load_collaborator
        @collaborators.all(full_name: @email)['collaborators'].first
      end
    end
  end
end
