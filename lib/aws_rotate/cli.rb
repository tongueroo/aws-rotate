module AwsRotate
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "list", "list profiles in ~/.aws"
    long_desc Help.text(:list)
    def list
      List.new(options).run
    end

    desc "key", "rotate key for AWS_PROFILE profile"
    long_desc Help.text(:key)
    def key
      Backup.new(options).run
      Key.new(options).run
    end

    desc "keys", "rotate keys for all profiles in ~/.aws/credentials"
    long_desc Help.text(:keys)
    def keys
      Backup.new(options).run
      Keys.new(options).run
    end

    desc "completion *PARAMS", "Prints words for auto-completion."
    long_desc Help.text("completion")
    def completion(*params)
      Completer.new(CLI, *params).run
    end

    desc "completion_script", "Generates a script that can be eval to setup auto-completion."
    long_desc Help.text("completion_script")
    def completion_script
      Completer::Script.generate
    end

    desc "version", "prints version"
    def version
      puts VERSION
    end
  end
end
