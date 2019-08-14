module AwsRotate
  class Keys < Base
    def run
      list = List.new(@options)
      list.profiles.each do |profile|
        next unless filter_match?(profile)

        ENV['AWS_PROFILE'] = profile
        Key.new(@options).run
      end
    end

    def filter_match?(profile)
      return true if @options[:select].nil? && @options[:reject].nil?

      unless @options[:reject].nil?
        reject_list = @options[:reject]
        reject_list.map! { |f|  Regexp.new(f) }
        rejected = !!reject_list.detect do |regexp|
          profile =~ regexp
        end
        return false if rejected
      end

      return true if @options[:select].nil?

      select_list = @options[:select]
      select_list.map! { |f|  Regexp.new(f) }
      selected = !!select_list.detect do |regexp|
        profile =~ regexp
      end
      selected
    end
  end
end
