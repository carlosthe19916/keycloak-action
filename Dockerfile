FROM quay.io/keycloak/keycloak:12.0.1

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
