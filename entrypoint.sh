#!/bin/sh -l

$JBOSS_HOME/kcadm.sh config credentials \
--server $1 \
--user $2 \
--password $3 \
--realm master \
--client admin-cli

eval $JBOSS_HOME/kcadm.sh $4
