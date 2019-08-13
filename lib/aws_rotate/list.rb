module AwsRotate
  class List < Base
    def initialize(options={})
      super
      @config_path = options[:config] || "#{ENV['HOME']}/.aws/config"
      @credentials_path = options[:credentials] || "#{ENV['HOME']}/.aws/credentials"
    end

    def run
      puts "AWS Profiles:"
      puts profiles
    end

    def profiles
      lines = IO.readlines(@credentials_path)
      profiles = []
      lines.each do |line|
        md = line.match(/\[(.*)\]/)
        profiles << md[1] if md
      end
      profiles
    end
  end
end
