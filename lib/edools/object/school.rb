require 'edools/resource/courses'

module Edools
  module Object
    class School
      attr_accessor :data

      KEYS_UPDATE = %w[
        name subdomain domains rdstation_token adroll_adv_id adroll_pix_id
        email phone cnpj samba_key samba_player_key samba_access_token
        samba_project_id terms_of_use adroll_adv_id adroll_pix_id facebook
        twitter linkedin pinterest google_plus youtube instagram site
        address company_name seo_title seo_description logo metadata
        meta_available_locales event
      ].freeze

      def initialize(settings, data)
        @settings = settings
        @data = data
      end

      def courses
        @courses ||= Resource::Courses.new(@settings, @data['subdomain'])
      end

      def update
        opts = { school: data_to_update }
        response = request.put("/schools/#{@data['id']}", opts)
        raise 'Object not update' if response.status != 204
      end

      private

      def data_to_update
        @data.select { |k, _| KEYS_UPDATE.include?(k) }
      end

      def request
        Edools::Request.new(@settings)
      end
    end
  end
end
