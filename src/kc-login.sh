#!/usr/bin/env bash

set -e

kcadm="$HOME/bin/kcadm.sh"

for var in "KC_SERVER" "KC_REALM" "KC_USER" "KC_PASSWORD"; do
  value="${!var}"
  if [ -z "${value}" ]; then
    echo "${var} is not defined"
    exit 1
  fi
done

"${kcadm}" config credentials \
  --server "${KC_SERVER}" \
  --realm "${KC_REALM}" \
  --user "${KC_USER}" \
  --password "${KC_PASSWORD}"
