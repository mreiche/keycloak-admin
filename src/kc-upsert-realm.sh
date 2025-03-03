#!/usr/bin/env bash

kcadm="$HOME/bin/kcadm.sh"

file="$1"

if [ ! -e "${file}" ]; then
  echo "File not found: ${file}"
  exit 1
fi

realm_id=$(jq -r '.id' "${file}")

if [ -z "${realm_id}" ]; then
  echo ".id not found in '${file}'"
  exit 1
fi

existing_realm=$("${kcadm}" get realms --fields 'id' | jq -c ".[] | select(.id == \"${realm_id}\")" | jq -r .id)

if [ -z "${existing_realm}" ]; then
  echo "Create realm '${realm_id}' from file '${file}"
  "${kcadm}" create realms -f "${file}"
else
  echo "Update realm '${realm_id}' from file '${file}"
  "${kcadm}" update "realms/${realm_id}" -f "${file}"
fi

exit $?
