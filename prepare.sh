#!/bin/bash -l

mkdir -p /tmp/keycloak/bin

KEYCLOAK_IMG=quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

KEYCLOAK_BIN_DIRECTORY="/opt/keycloak/bin"
KEYCLOAK_LEGACY_BIN_DIRECTORY="/opt/jboss/keycloak/bin"

BIN_DIRECTORY=""
if [ ${KEYCLOAK_VERSION} = "latest" ]; then 
    BIN_DIRECTORY=${KEYCLOAK_BIN_DIRECTORY}
else
    major_version=$(("$(echo $KEYCLOAK_VERSION | cut -d'.' -f1)"))        
    if (( major_version > 19 )); then
        BIN_DIRECTORY=${KEYCLOAK_BIN_DIRECTORY}
    else
        BIN_DIRECTORY=${KEYCLOAK_LEGACY_BIN_DIRECTORY}
    fi;
fi;

docker cp $(docker create --name download $KEYCLOAK_IMG ls):${BIN_DIRECTORY} /tmp/keycloak && docker rm download
