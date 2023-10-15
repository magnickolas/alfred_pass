# alfred pass workflow

[Alfred][alfred] workflow utilities for [pass][pass] password manager.

## Quickstart

Download the workflow for your architecture (amd64 for Intel chips, arm64 for Apple silicon) and install it in Alfred.

Type:

- `pass <query>` to search for a password (the list will be sorted in ad-hoc relevancy order) and copy it to clipboard
- `pass-opt <query>` same as above but copy the attached OTP
- `pass-gen <arg ...>` wraps `pass generate <arg ...>` and then copies the generated password to clipboard

## Build from source

Requirements:

- Git
- GNU Make
- Go 1.16+

Run the following commands:

```
git clone https://github.com/magnickolas/alfred_pass
cd alfred_pass
make
```

This builds the workflow for your architecture in the repo's directory.

To build for another architecture run `make ARCH=amd64` or `make ARCH=arm64` instead of `make`.

[alfred]: https://www.alfredapp.com/
[pass]: https://www.passwordstore.org/
