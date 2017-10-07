require 'csv'
require 'open-uri'
require 'edools/importer/user'

module Edools
  class Loader
    class Csv
      def initialize(settings, path, opts = {})
        raise 'no settings' if settings.nil?
        @settings = settings
        @path = path
        @remote = opts[:remote]
      end

      def start
        ::CSV.parse(data, headers: :first_row, col_sep: ';').each do |line|
          import_opts = {
            first_name: line[0], email: line[1], type: line[2],
            school_product_id: line[3].to_i
          }
          Importer::User.new(@settings, import_opts).import
        end
      end

      private

      def data
        if @remote
          open(@path).read
        else
          File.read(@path)
        end
      end
    end
  end
end
