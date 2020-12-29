#!/bin/sh -l

$JBOSS_HOME/bin/kcadm.sh config credentials \
--server $1 \
--user $2 \
--password $3 \
--realm $4 \
--client $5

eval $JBOSS_HOME/bin/kcadm.sh $6
