# alfred pass workflow

[Alfred][alfred] workflow utilities for [pass][pass] password manager.

## Quickstart

Download `pass.alfredworkflow` from [the latest release](https://github.com/magnickolas/alfred_pass/releases/latest) and open it.

In Alfred bar type:

- `pass <query>` to search for a password (the list will be sorted in ad-hoc relevancy order) and copy it to clipboard
- `pass-opt <query>` same as above but copy the attached OTP
- `pass-gen <arg ...>` wraps `pass generate <arg ...>` and then copies the generated password to clipboard

## Build from source

Requirements:

- Git
- GNU Make
- Go 1.16+
- Xcode 12.2+

Run the following commands:

```
git clone https://github.com/magnickolas/alfred_pass
cd alfred_pass
make
```

This builds the workflow (universal for both x86_64 and arm64 architectures) in the repo's directory.

[alfred]: https://www.alfredapp.com/
[pass]: https://www.passwordstore.org/
