require "aws-sdk-iam"

module AwsRotate
  module AwsServices
    extend Memoist

    def iam
      Aws::IAM::Client.new
    end
    memoize :iam
  end
end
