# Keycloak Admin CLI
Github Action for executing [Keycloak](https://www.keycloak.org/) Admin CLI against a defined server.

You can read more about Keycloak Admin CLI in the official [documentation](https://www.keycloak.org/docs/latest/server_admin/index.html#the-admin-cli).

## Usage
To execute one or more commands using the Keycloak Admin CLI within your Github Actions pipeline include `carlosthe19916/keycloak-action@0.6` in your `workflow.yml` file.

Inside your `.github/workflows/workflow.yml` file:

```yaml
steps:
- uses: actions/checkout@v2
- name: Keycloak Admin CLI
  uses: carlosthe19916/keycloak-action@0.6
  with:
    version: latest
    server: http://keycloak:8080
    username: admin
    password: password
    kcadm: create realms -f openubl-realm.json
```

To execute more than one command:

```yaml
steps:
- uses: actions/checkout@v2
- name: Keycloak Admin CLI
  uses: carlosthe19916/keycloak-action@0.4
  with:
    server: http://keycloak:8080/auth
    username: admin
    password: password
    kcadm: |
      create realms -f openubl-realm.json
      create clients -r openubl -s clientId=myClient -s enabled=true
```

## Arguments
There are 6 arguments available:


| Input        | Description           | Usage  |
| ------------ |:---------------------:| ------:|
| version      | The Keycloak client version to use |
| server       | The server URL e.g. http://localhost:8080/auth | Required |
| username     | The username to start a session.      |   Required |
| password     | The password to start a session.      |   Required |
| realm        | The realm to start a session against to (default master).      |   Optional |
| client       | The client to start a session against to (default admin-cli).      |   Optional |
| kcadm        | The command (or commands) to execute after authenticated in Keycloak e.g. update realms/rhamt -f rhamt-realm.json . To execute more than one command, use "\|" and type the commands on multiple lines. |    Required |
| server-wait-timeout | Time (seconds) to wait until server is available (default 120 seconds). |    Optional |

## Example `workflow.yml` with keycloak Admin CLI

```yaml
name: Example workflow for Keycloak Admin CLI
on: [push]
jobs:
  example:
    runs-on: ubuntu-latest
    steps:
      - name: Init Keycloak
        run: |
          docker run -d --name keycloak -p 8080:8080 \
          -e KEYCLOAK_ADMIN=admin \
          -e KEYCLOAK_ADMIN_PASSWORD=password \
          quay.io/keycloak/keycloak:latest start-dev
      - name: Keycloak Admin CLI
        uses: carlosthe19916/keycloak-action@0.6
        with:
          version: latest
          server: http://localhost:8080
          username: admin
          password: password
          kcadm: |
            get realms
```
