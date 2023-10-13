#!/usr/bin/env bash

set -e

pass otp "$1" | head -n 1 | tr -d '\n'
