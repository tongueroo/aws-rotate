module AwsRotate
  class List < Base
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
