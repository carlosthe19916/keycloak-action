#!/bin/bash -l

attempt_counter=0

interval=3
max_attempts=$(($6/interval));

## Wait until server is ready to continue
until (curl --output /dev/null --silent --head --fail $1); do
  if [ ${attempt_counter} -eq ${max_attempts} ];then
    echo "Max attempts reached"
    exit 1
  fi

  printf '.'
  attempt_counter=$(($attempt_counter+1))
  sleep $interval
done

## Login
$JBOSS_HOME/bin/kcadm.sh config credentials \
--server $1 \
--user $2 \
--password $3 \
--realm $4 \
--client $5

## remove empty strings and parse command lines
readarray -t lines <<< "$(echo "$7" | sed '/^$/d')"

## Execute kcadm.sh for each command line
for l in "${lines[@]}";
do
  echo "::debug title=command execution::Executing command $l"
  eval "$JBOSS_HOME/bin/kcadm.sh $l";
done





