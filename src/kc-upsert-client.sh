#!/usr/bin/env bash

kcadm="$HOME/bin/kcadm.sh"

if [ -z "${KC_REALM}" ]; then
  echo "KC_REALM is not defined"
  exit 1
fi

file="$1"

if [ ! -e "${file}" ]; then
  echo "File not found: ${file}"
  exit 1
fi

client_id=$(jq -r '.clientId' "${file}")

if [ -z "${client_id}" ]; then
  echo ".clientId not found in '${file}'"
  exit 1
fi

client_uuid=$("${kcadm}" get clients -r "${KC_REALM}" --fields 'id,clientId' | jq -c ".[] | select(.clientId == \"${client_id}\")" | jq -r .id)

if [ -z "${client_uuid}" ]; then
  echo "Create client '${KC_REALM}/${client_id}' from file '${file}"
  "${kcadm}" create clients -r "${KC_REALM}" -f "${file}"
else
  echo "Update client '${KC_REALM}/${client_id}' from file '${file}"
  "${kcadm}" update "clients/${client_uuid}" -r "${KC_REALM}" -f "${file}"
fi

exit $?
