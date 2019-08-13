module AwsRotate
  class Base
    include AwsServices

    def initialize(options={})
      @options = options
      @config_path = options[:config] || "#{ENV['HOME']}/.aws/config"
      @credentials_path = options[:credentials] || "#{ENV['HOME']}/.aws/credentials"
      @profile = ENV['AWS_PROFILE'] || default_profile
    end

  private
    def default_profile
      if ENV['AWS_PROFILE'].nil?
        lines = IO.readlines(@credentials_path)
        default_found = lines.detect { |l| l =~ /\[default\]/ }
        'default'
      else
        abort("AWS_PROFILE must be set")
      end
    end

    def sh(command)
      # no puts so we dont puts out the secret key value
      # puts "=> #{command}" # uncomment to debug
      success = system(command)
      raise unless success
    end
  end
end
