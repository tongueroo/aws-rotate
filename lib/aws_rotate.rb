$:.unshift(File.expand_path("../", __FILE__))
require "aws_rotate/version"
require "rainbow/ext/string"
require "memoist"

require "aws_rotate/autoloader"
AwsRotate::Autoloader.setup

module AwsRotate
  class Error < StandardError; end
end
