# AwsRotate

[![Gem Version](https://badge.fury.io/rb/aws-rotate.png)](http://badge.fury.io/rb/aws-rotate)
[![Support](https://img.shields.io/badge/get-support-blue.svg)](https://boltops.com?utm_source=badge&utm_medium=badge&utm_campaign=aws-rotate)

Rotates your AWS keys configured in `~/.aws/credentials`.

## Usage

    aws-rotate list # list profiles in ~/.aws
    aws-rotate key  # rotates single key. Uses AWS_PROFILE env var
    aws-rotate keys # rotates **all** keys for all profiles in ~/.aws/credentials

## aws-rotate keys

IMPORTANT: The `aws-rotate keys` command will update **all** the profiles found in `~/.aws/credentials`.  You may want to run an `--noop` to first test. Example:

    aws-rotate keys --noop

If you would like to selectively update profiles, you can use the `--select` option. Example:

    aws-rotate keys --select dev-

The `--select dev-` results in only profiles with the `dev-` found in the profile name to be updated.  Example:

~/.aws/credentials:

```
[my-dev-account1]
aws_access_key_id=EXAMPLE1
aws_secret_access_key=EXAMPLE1

[my-dev-account2]
aws_access_key_id=EXAMPLE2
aws_secret_access_key=EXAMPLE2

[my-prod-account]
aws_access_key_id=EXAMPLE3
aws_secret_access_key=EXAMPLE3
```

Will only update `my-dev-account1` and `my-dev-account1`, since they both include the `dev-` pattern.

The select option can take multiple selects. Example:

    aws-rotate keys --select dev- test-

Also, the select option is internally converted to an ruby regexp. So you can use patterns. Example:

    aws-rotate keys --select ^dev-

In this case the match is stricter and must start with "dev"

## Backups

A backup of your `~/.aws/credentials` file is taken and stored in `~/.aws/credentials-bak-[timestamp]` before it is updated. However, please take precaution and take your own backup measures.

## Assume Roles

Note :assumed role profiles are skipped as they don't have access keys.

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
