#!/usr/bin/env bash

set -e

pass show "$1" | head -n 1 | tr -d '\n'
