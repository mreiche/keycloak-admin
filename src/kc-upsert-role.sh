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

role_name=$(jq -r '.name' "${file}")

if [ -z "${role_name}" ]; then
  echo ".name not found in '${file}'"
  exit 1
fi

existing_role_name=$("${kcadm}" get roles -r "${KC_REALM}" | jq ".[] | select(.name == \"${role_name}\")" | jq -r .name)

if [ -z "${existing_role_name}" ]; then
  echo "Create role '${KC_REALM}/${role_name}' from file '${file}"
  "${kcadm}" create roles -r "${KC_REALM}" -f "${file}"
else
  echo "Update role '${KC_REALM}/${role_name}' from file '${file}"
  "${kcadm}" update "roles/${role_name}" -r "${KC_REALM}" -f "${file}"
fi

exit $?
