# Change Log

All notable changes to this project will be documented in this file.
This project *tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

## [0.4.0]
- dont rotate aws profiles that have mfa_serial in them. For aws-mfa-secure gem.

## [0.3.0]
- only rotate profiles with keys. skip profiles using assumed role.

## [0.2.0]
- continue rotating when hit max keys limit on a profile
- improve GetIamUserError message for key command

## [0.1.0]
- Initial release.
