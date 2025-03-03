# Keycloak Admin

Vanilla *Keycloak* with additional tools (like *jq*, *curl*) and shell scripts for upserting entities.

## Usage examples

```shell
export PATH=$PATH:$HOME/bin

KC_SERVER="http://host.containers.internal:8080"
KC_USER="admin"
KC_PASSWORD="admin"

KC_REALM="master" kc-login.sh
kc-upsert-realm.sh /path/realm.json
KC_REALM="customer" kc-upsert-client.sh /path/client.json
```

## Build and test the image
```shell
podman build -f Dockerfile -t keycloak-admin
podman run -it --rm --entrypoint bash \
  --env-file="$(pwd)/test/test.env" \
  -v "$(pwd)/test:/test" \
  -v "$(pwd)/src:/usr/local/bin" \
  keycloak-admin
```
Within the container
```shell
KC_REALM="master" kc-login.sh
kc-upsert-realm.sh /test/test-realm.json
kc-upsert-client.sh /test/test-client.json
kc-upsert-role.sh /test/test-role.json
kc-add-roles.sh "service-account-test_client" "client-service-account"
```

## References

- Extend Keycloak-Container: https://www.keycloak.org/server/containers
- Admin-CLI Homepage: https://www.keycloak.org/docs/latest/server_admin/index.html#admin-cli
- Examples
  - Update Realm via JSON: https://stackoverflow.com/questions/66447652/keycloak-admin-cli-updating-a-realm-with-json-file
  - Get Client UUID: https://gist.github.com/thomasdarimont/bb702bd1160eb200147cf1bee1c1f7ed
  - More examples: https://medium.com/@rishabhsvats/using-kcadm-in-keycloak-668a592691f4
