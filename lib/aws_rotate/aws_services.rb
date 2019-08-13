require "aws-sdk-iam"
require "aws-sdk-sts"

module AwsRotate
  module AwsServices
    extend Memoist

    def iam
      Aws::IAM::Client.new
    end
    memoize :iam

    def sts
      Aws::STS::Client.new
    end
    memoize :sts
  end
end
