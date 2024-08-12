ARG KEYCLOAK_VERSION=latest
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

# Keycloak 21+ doesn't have curl, workaround for https://github.com/keycloak/keycloak/issues/17273
ADD --chown=root:root https://github.com/moparisthebest/static-curl/releases/latest/download/curl-amd64 /usr/bin/curl
USER root
RUN chmod +x /usr/bin/curl

USER keycloak
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
