# alfred pass workflow

[Alfred][alfred] workflow utilities for [pass][pass] password manager.

## Quickstart

Download the workflow for your architecture (amd64 for Intel chips, arm64 for M1/M2) and install it in Alfred.

Type:

- `pass <query>` to search for a password (the list will be sorted in ad-hoc relevancy order) and copy it to clipboard
- `pass-opt <query>` same as above but copy the attached OTP
- `pass-gen <arg ...>` wraps `pass generate <arg ...>` and then copies the generated password to clipboard

## Build from source

Requirements:

- GNU Make 4.4+
- Go 1.16+

[alfred]: https://www.alfredapp.com/
[pass]: https://www.passwordstore.org/
