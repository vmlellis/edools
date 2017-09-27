module Edools
  class Settings
    attr_accessor :token, :school_id, :http_logger
    attr_reader :enviroment

    def initialize(opts = {})
      @enviroment = 'staging'
      @token = opts[:token]
    end

    def url
      'https://core.myedools.info/'
    end
  end
end
