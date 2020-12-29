#!/bin/sh -l

realm="${4:-master}"
client="${5:-admin-cli}"

$JBOSS_HOME/bin/kcadm.sh config credentials \
--server $1 \
--user $2 \
--password $3 \
--realm $realm \
--client $client

eval $JBOSS_HOME/bin/kcadm.sh $6
