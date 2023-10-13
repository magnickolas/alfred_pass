#!/usr/bin/env bash

set -e

read -ra args <<<"$1"
pass generate "${args[@]}" 2>/dev/null | tail -n 1 | tr -d '\n'
