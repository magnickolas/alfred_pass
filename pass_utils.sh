#!/usr/bin/env bash

set -e

get_password() {
	pass show -c1 "$1"
}

get_otp() {
	pass otp -c "$1"
}

generate_password() {
	read -ra args <<<"$1"
	pass generate -c "${args[@]}"
}

case "$1" in
get) get_password "${@:2}" ;;
get_otp) get_otp "${@:2}" ;;
gen) generate_password "${@:2}" ;;
esac
