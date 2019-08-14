require "aws-sdk-iam"
require "aws-sdk-sts"

module AwsRotate
  module AwsServices
    # Memoization takes into account different AWS_PROFILE
    @@iam = {}
    def iam
      @@iam[ENV['AWS_PROFILE']] ||= Aws::IAM::Client.new
    end

    @@sts = {}
    def sts
      @@sts[ENV['AWS_PROFILE']] ||= Aws::STS::Client.new
    end
  end
end
