#!/usr/bin/env bash

set -e

get_password() {
	pass show "$1" | head -n1
}

copy_password() {
	pass show -c1 "$1"
}

get_otp() {
	pass otp "$1"
}

copy_otp() {
	pass otp -c "$1"
}

generate_password() {
	read -ra args <<<"$1"
	pass generate "${args[@]}" | head -n1
}

generate_and_copy_password() {
	read -ra args <<<"$1"
	pass generate -c "${args[@]}"
}

type_string() {
    echo "$1" | osascript 3<&0 <<EOF
    on typeString(inputString)
        tell application "System Events"
            keystroke inputString
        end tell
    end typeString

    set inputText to (do shell script "cat 0<&3")

    repeat with i from 1 to count characters of inputText
        set currentChar to character i of inputText as text
        typeString(currentChar)
    end repeat
EOF
}

case "$1" in
get) type_string "$(get_password "${@:2}")" ;;
get_otp) type_string "$(get_otp "${@:2}")" ;;
gen) type_string "$(generate_password "${@:2}")" ;;
copy) copy_password "${@:2}" ;;
copy_otp) copy_otp "${@:2}" ;;
copy_gen) generate_and_copy_password "${@:2}" ;;
esac
