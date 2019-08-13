module AwsRotate
  class Base
    include AwsServices

    def initialize(options={})
      @options = options
      @config_path = options[:config] || "#{ENV['HOME']}/.aws/config"
      @credentials_path = options[:credentials] || "#{ENV['HOME']}/.aws/credentials"
    end
  end
end
