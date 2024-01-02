# alfred pass workflow

[Alfred][alfred] workflow utilities for [pass][pass] password manager.

## Prerequisites

- [Alfred][alfred] with Powerpack (paid)
- [pass][pass]
- [pass-otp][pass-otp]

## Quickstart

Download `pass.alfredworkflow` from [the latest release](https://github.com/magnickolas/alfred_pass/releases/latest) and open it.

In Alfred bar type:

- `pass <query>` searches for a password (the list will be sorted in ad-hoc relevancy order) and types it to the currently focused window. `pass-copy <query>` copies to clipboard instead.
- `pass-otp <query>` same as above but types the attached one-time password. `pass-otp-copy <query>` copies instead.
- `pass-gen <arg ...>` wraps `pass generate <arg ...>` and then types the generated password. `pass-gen-copy <arg ...>` copies instead.

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
[pass-otp]: https://github.com/tadfisher/pass-otp
