#!/usr/bin/env bash

user=$1

cd /tmp && /mqtt/generate-CA.sh client $user
cd /tmp && \
  openssl pkcs12 -export -in $user.crt -inkey $user.key \
  -name "$user's owntracks key" -out $user.otrp

echo -e "Generated user key for $user"
cat $user.otrp
