module AwsRotate
  class List < Base
    def initialize(options={})
      super
      @lines = IO.readlines(@credentials_path)
    end

    def run
      puts "AWS Profiles:"
      puts profiles
      profiles
    end

    # Only returns profiles that have aws_access_key_id without mfa_serial
    def profiles
      iam_profiles = find_profiles(/^aws_access_key_id/)
      mfa_profiles = find_profiles(/^mfa_serial/)
      iam_profiles - mfa_profiles
    end

    def find_profiles(regexp)
      has_key, within_profile, profiles = false, false, []
      all_profiles.each do |profile|
        @lines.each do |line|
          line = line.strip
          within_profile = false if line =~ /^\[/ # on the next profile section, reset flag
          within_profile ||= line == "[#{profile}]" # enable checking
          if within_profile
            has_key = line =~ regexp
            if has_key
              profiles << profile
              break
            end
          end
        end
      end
      profiles
    end

    def all_profiles
      all_profiles = []
      @lines.each do |line|
        next if line =~ /^\s*#/ # ignore comments

        md = line.match(/\[(.*)\]/)
        all_profiles << md[1] if md
      end
      all_profiles
    end
  end
end
