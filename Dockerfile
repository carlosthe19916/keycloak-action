ARG KEYCLOAK_VERSION=latest
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}
ADD ./curl-aarch64 /opt/curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
