# AwsRotate

[![Gem Version](https://badge.fury.io/rb/aws-rotate.png)](http://badge.fury.io/rb/aws-rotate)
[![Support](https://img.shields.io/badge/get-support-blue.svg)](https://boltops.com?utm_source=badge&utm_medium=badge&utm_campaign=aws-rotate)

Rotates your ~/.aws keys.

## Usage

    aws-rotate list # list profiles in ~/.aws
    aws-rotate key  # rotates single key. Uses AWS_PROFILE env var
    aws-rotate keys # rotates **all** keys for all profiles in ~/.aws/credentials

## Installation

Add this line to your application's Gemfile:

    gem "aws-rotate"

And then execute:

    bundle

Or install it yourself as:

    gem install aws-rotate

## Requirements

The [aws cli](https://aws.amazon.com/cli/) is use to set the access keys and is required.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
