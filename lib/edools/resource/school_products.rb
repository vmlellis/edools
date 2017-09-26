require 'edools/object/school_product'

module Edools
  module Resource
    class SchoolProducts
      def initialize(settings, subdomain)
        @endpoint = '/api/school_products'
        @settings = settings
        @request = Request.new(settings, subdomain)
      end

      def all
        response = @request.get(@endpoint)
        data = Oj.load(response.body)
        data['school_products'].map! do |school_product|
          Object::Course.new(@settings, school_product)
        end
        data
      end

      def create(title, extra = {})
        opts = extra.merge(title: title)
        response = @request.post(@endpoint, school_product: opts)
        data = Oj.load(response.body)
        Object::SchoolProduct.new(@settings, data)
      end
    end
  end
end
