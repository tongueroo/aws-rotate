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

Example output:

    $ aws-rotate keys
    Backed up credentials file at: /home/ec2-user/.aws/credentials.bak-2019-08-14-16:45:36
    Updating access key for AWS_PROFILE=profile1
    Created new access key: AKIAXZ6ODJLQWYW3575A
    Updated profile profile1 in /home/ec2-user/.aws/credentials with new key: AKIAXZ6ODJLQWYW3575A
    Old access key deleted: AKIAXZ6ODJLQ3Q5TJUHN
    Please note, it sometimes take a few seconds or even minutes before the new IAM access key is usable.
    Updating access key for AWS_PROFILE=default
    Updated profile default in /home/ec2-user/.aws/credentials with new key: AKIAXZ6ODJLQWYW3575A
    Please note, it sometimes take a few seconds or even minutes before the new IAM access key is usable.
    $

### select filter option

If you would like to selectively update profiles, you can use the `--select` option. The `-s` option is also shorthand for the `--select` option. Example:

    aws-rotate keys --select dev-

The `--select dev-` results in only profiles with the `dev-` found in the profile name to be updated.  Example:

~/.aws/credentials:

    [my-dev-account1]
    aws_access_key_id=EXAMPLE1
    aws_secret_access_key=EXAMPLE1

    [my-dev-account2]
    aws_access_key_id=EXAMPLE2
    aws_secret_access_key=EXAMPLE2

    [my-prod-account]
    aws_access_key_id=EXAMPLE3
    aws_secret_access_key=EXAMPLE3

Will only update `my-dev-account1` and `my-dev-account1`, since they both include the `dev-` pattern.

The select option can take multiple selects. Example:

    aws-rotate keys --select dev- test-

Also, the select option is internally converted to an ruby regexp. So you can use patterns. Example:

    aws-rotate keys --select ^dev-

In this case the match is stricter and must start with "dev"

### reject filter option

There is also a `--reject` and `-r` option that does the opposite of the `--select` option.

    aws-rotate keys --reject ^prod-

Will rotate all profiles that do not match `^prod-`.

You can use both `--select` and `--reject` options together.

## Backups

A backup of your `~/.aws/credentials` file is taken and stored in `~/.aws/credentials-bak-[timestamp]` before it is updated. However, please take precaution and take your own backup measures.  You can also disable backups with the `--no-backup` option.

## Assume Roles

Note: assumed role profiles are skipped as they don't have access keys.

## Automatically Updating with Cron

You can add a crontab to your system to automatically rotate the keys:

    crontab -e

You can add something like this:

    30 20 * * * bash -l -c 'aws-rotate keys --select dev-aws-profile test-aws-profile --no-backup >> /var/log/cron-aws-rotate.log 2>&1' # rotate AWS keys daily

Create a `/var/log/cron-aws-rotate.log` that is writable with your user:

    sudo touch /var/log/cron-aws-rotate.log
    sudo chown `whoami`:`whoami` /var/log/cron-aws-rotate.log

## Installation

You can install the tool with:

    gem install aws-rotate

## Requirements

The [aws cli](https://aws.amazon.com/cli/) is use to set the access keys and is required.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
