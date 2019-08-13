module AwsRotate
  class Base
    include AwsServices

    def initialize(options={})
      @options = options
    end
  end
end
