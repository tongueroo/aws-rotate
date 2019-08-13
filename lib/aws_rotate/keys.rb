module AwsRotate
  class Keys < Base
    def run
      check_profiles_using_same_key!

      list = List.new(@options)
      list.profiles.each do |profile|
        ENV['AWS_PROFILE'] = profile
        puts profile
        # Key.new(options).run
      end
    end

    def check_profiles_using_same_key!
      access_keys = []
      lines = IO.readlines(@credentials_path)
      lines.each do |l|
        next if l =~ /\w*#/ # disregard comments
        next unless l.include?('aws_access_key_id') # only looking for aws_access_key_id keys

        v = l.split('=').last.strip
        access_keys << v
      end

      if access_keys.uniq.size > 1
        # Thanks: https://stackoverflow.com/questions/569694/how-to-count-duplicate-elements-in-a-ruby-array
        # make the hash default to 0 so that += will work correctly
        result = Hash.new(0)
        # iterate over the array, counting duplicate entries
        access_keys.each { |v| result[v] += 1 }

        puts <<~EOL.color(:red)
          ERROR: There are multiple profiles that use the same access keys. aws-rotate loops through all the profiles
          and update each of them. By the time it gets the 2nd key it wont be able to update it.
        EOL
        result.each do |k, v|
          if v > 1
            puts "#{k} is used #{v} times"
          end
        end

        exit 1
      end
    end
  end
end
