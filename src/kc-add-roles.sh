#!/usr/bin/env bash

kcadm="$HOME/bin/kcadm.sh"

user="$1"
roles="$2"

if [ -z "${user}" ]; then
  echo "No user given"
  exit 1
fi

if [ -z "${roles}" ]; then
  echo "No roles given"
  exit 1
fi

if [ -z "${KC_REALM}" ]; then
  echo "KC_REALM is not defined"
  exit 1
fi

echo "Add roles '${roles}' to user '${KC_REALM}/${user}'"
"${kcadm}" add-roles -r "${KC_REALM}" --uusername "service-account-${KC_CLIENT}" --rolename "${roles}"

exit $?
