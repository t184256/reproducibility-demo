#!/usr/bin/env bash
set -e

FILE=$1
if [[ -z "$FILE" ]]; then echo "$0 <filename> [uploader_name]" >&2; exit 1; fi
UPLOADER=$2
[[ -n "$UPLOADER" ]] || UPLOADER=$USER
UPLOAD_SERVER=${UPLOAD_SERVER:-https://diff.unboiled.info}
# ^ must run https://github.com/t184256/diffoscope-server

exec curl -F "file=@$FILE" -F "uploader=$UPLOADER" "$UPLOAD_SERVER/upload"
