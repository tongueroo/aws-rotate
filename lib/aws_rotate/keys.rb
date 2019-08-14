module AwsRotate
  class Keys < Base
    def run
      list = List.new(@options)
      list.profiles.each do |profile|
        ENV['AWS_PROFILE'] = profile
        Key.new(@options).run
      end
    end
  end
end
