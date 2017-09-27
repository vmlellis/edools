require 'edools/object/school_product'

module Edools
  module Resource
    # Resource to school products
    class SchoolProducts
      def initialize(settings, subdomain, school_id)
        @endpoint = "/api/schools/#{school_id}/school_products"
        @settings = settings
        @request = Request.new(settings, subdomain)
      end

      def all
        response = @request.get(@endpoint)
        data = Oj.load(response.body)
        data['school_products'].map! do |school_product|
          Object::SchoolProduct.new(@settings, school_product)
        end
        data
      end

      def create(title, extra = {})
        opts = extra.merge(title: title)
        response = @request.post(@endpoint, school_product: opts)
        data = Oj.load(response.body)
        Object::SchoolProduct.new(@settings, data)
      end

      def find(id)
        response = @request.get("#{@endpoint}/#{id}")
        data = Oj.load(response.body)
        Object::SchoolProduct.new(@settings, data)
      end

      def update(product)
        opts = { school_product: product.data_to_update }
        response = @request.put("#{@endpoint}/#{product.id}", opts)
        raise 'Product not updated' if response.status != 204
      end
    end
  end
end
