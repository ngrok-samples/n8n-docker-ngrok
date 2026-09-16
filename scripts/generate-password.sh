#!/usr/bin/env bash

set -euo pipefail

length="$1"
if ! [[ "$length" =~ ^[1-9][0-9]*$ ]]; then
    echo "Length must be a positive integer." >&2
    exit 1
fi

password=""
while ((${#password} < length)); do
    password+="$(LC_ALL=C openssl rand -base64 "$length" | tr -dc 'A-Za-z0-9')"
done
printf '%s' "${password:0:length}"
