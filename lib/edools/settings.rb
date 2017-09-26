module Edools
  class Settings
    attr_accessor :token
    attr_reader :enviroment

    def initialize(opts = {})
      @enviroment = 'staging'
      @token = opts[:token]
    end

    def url(subdomain)
      "https://#{subdomain || 'core'}.myedools.info/"
    end
  end
end
