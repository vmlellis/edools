module Edools
  class Settings
    attr_accessor :token, :subdomain, :school_id, :http_logger
    attr_reader :enviroment

    def initialize(opts = {})
      @enviroment = 'staging'
      @token = opts[:token]
      @subdomain = opts[:subdomain]
    end

    def url
      "https://#{@subdomain || 'core'}.myedools.info/"
    end
  end
end
