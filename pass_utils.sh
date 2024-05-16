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
    pass generate "${args[@]}" -f &>/dev/null
    pass show "$(extract_path_from_gen_arguments "${args[@]}")" | head -n1
}

generate_and_copy_password() {
    read -ra args <<<"$1"
    pass generate -c "${args[@]}" -f
}

find_getopt() {
    echo "$({ test -x /usr/local/opt/gnu-getopt/bin/getopt && echo /usr/local/opt/gnu-getopt; } || brew --prefix gnu-getopt 2>/dev/null || { which port &>/dev/null && echo /opt/local; } || echo /usr/local)/bin/getopt"
}

extract_path_from_gen_arguments() {
    local opts
    opts="$($(find_getopt) -o nqcif -l no-symbols,qrcode,clip,in-place,force -n pass -- "$@")"
    eval set -- "$opts"
    while true; do case $1 in
        -n|--no-symbols) shift ;;
        -q|--qrcode) shift ;;
        -c|--clip) shift ;;
        -f|--force) shift ;;
        -i|--in-place) shift ;;
        --) shift; break ;;
    esac done

    local path="$1"
    echo "$path"
}

need_confirm_overwrite() {
    local opts force=0 inplace=0
    opts="$($(find_getopt) -o nqcif -l no-symbols,qrcode,clip,in-place,force -n pass -- "$@")"
    eval set -- "$opts"
    while true; do case $1 in
        -n|--no-symbols) shift ;;
        -q|--qrcode) shift ;;
        -c|--clip) shift ;;
        -f|--force) force=1; shift ;;
        -i|--in-place) inplace=1; shift ;;
        --) shift; break ;;
    esac done

    local prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
    local path="$1"
    local passfile="$prefix/$path.gpg"
    [[ $inplace -eq 0 && $force -eq 0 && -e $passfile ]]
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
need_confirm_overwrite) need_confirm_overwrite "${@:2}" && echo -n 1 || echo -n 0 ;;
*) echo "ERROR: unknown command" && exit 1 ;;
esac
