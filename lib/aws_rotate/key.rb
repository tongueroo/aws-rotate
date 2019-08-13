module AwsRotate
  class Key < Base
    class MaxKeysError < StandardError; end

    def run
      @user = get_iam_user # will only rotate keys that belong to an actual IAM user
      return unless @user

      check_max_keys_limit
      puts "Updating access key for AWS_PROFILE=#{@profile}"
      key = create_access_key
      backup_credentials
      update_aws_credentials_file(key.access_key_id, key.secret_access_key)
      delete_old_access_key
      patience_warning
      aws_environment_variables_warning
    end

    # Returns IAM username.
    # Returns nil unless this profile is actually associated with an user.
    def get_iam_user
      resp = sts.get_caller_identity
      arn = resp.arn
      # Example arns:
      #
      #    arn:aws:iam::112233445566:user/tung - iam user
      #    arn arn:aws:sts::112233445566:assumed-role/Admin/default_session - assume role
      #
      if arn.include?(':user/')
        arn.split('/').last
      end
    rescue Aws::Errors::MissingRegionError => e
      puts "ERROR: #{e.message}".color(:red)
      puts "The AWS_PROFILE=#{@profile} may not exist. Please double check it."
      exit 1
    rescue Aws::STS::Errors::InvalidClientTokenId => e
      puts "ERROR: #{e.message}".color(:red)
      puts "The AWS_PROFILE=#{@profile} profile does not have access to IAM. Please double check it."
      exit 1
    end

    # Check if there are 2 keys, cannot rotate if there are 2 keys already.
    # Display info message for user to reduce it to 1 key.
    MAX_KEYS = 2
    def check_max_keys_limit!
      resp = iam.list_access_keys(user_name: @user)
      return if resp.access_key_metadata.size < MAX_KEYS
      raise MaxKeysError
    end

    def check_max_keys_limit
      check_max_keys_limit!
    rescue MaxKeysError
      puts <<~EOL.color(:red)
        This user #{@user} has 2 access keys. This is the max number of keys allowed.
        Please remove at least one of the keys so aws-rotate can rotate the key.
      EOL
      exit 1
    end

    # Returns:
    #
    #   #<struct Aws::IAM::Types::AccessKey
    #     user_name="tung",
    #     access_key_id="AKIAXZ6ODJLQUU6O3FD2",
    #     status="Active",
    #     secret_access_key="8eEnLLdR7gQE9fkFiDVuemi3qPf3mBMXxEXAMPLE",
    #     create_date=2019-08-13 21:14:35 UTC>>
    #
    def create_access_key
      resp = iam.create_access_key
      key = resp.access_key
      puts "Created new access key: #{key.access_key_id}"
      resp.access_key
    end

    def backup_credentials
      ensure_dot_aws_exists
      backup_path = @credentials_path + ".bak-#{Time.now.strftime("%F-%T")}"
      FileUtils.cp(@credentials_path, backup_path)
      puts "Backed up credentials file at: #{backup_path}"
    end

    def ensure_dot_aws_exists
      FileUtils.mkdir_p(File.dirname(@credentials_path))
    end

    def update_aws_credentials_file(aws_access_key_id, aws_secret_access_key)
      aws_configure_set(aws_access_key_id: aws_access_key_id)
      aws_configure_set(aws_secret_access_key: aws_secret_access_key)
      puts "Updated profile #{@profile} in #{@credentials_path} with new key: #{aws_access_key_id}"
    end

    def delete_old_access_key
      resp = iam.list_access_keys
      access_keys = resp.access_key_metadata
      old_key = access_keys.sort_by(&:create_date).first
      iam.delete_access_key(access_key_id: old_key.access_key_id)
      puts "Old access key deleted: #{old_key.access_key_id}"
    end

    def patience_warning
      puts "Please note, it sometimes take a few seconds or even minutes before the new IAM access key is usable."
    end

    def aws_environment_variables_warning
      return unless ENV['AWS_ACCESS_KEY_ID'] || ENV['AWS_SECRET_ACCESS_KEY']

      puts <<~EOL
        WARN: The AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables are also set in your shell.
        You must update those yourself. This tool only updates thethe keys in ~/.aws.
      EOL
    end

  private

    # Use the aws cli to spare coding work from parsing it.
    def aws_configure_set(options={})
      k, v = options.keys.first, options.values.first
      sh "aws configure set #{k} #{v} --profile #{@profile}"
    end
  end
end