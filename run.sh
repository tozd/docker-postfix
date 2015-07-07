#!/bin/bash -e

# An example script to run Postifx in production. It uses data volumes under the $DATA_ROOT directory.
# By default /srv. By default it is configured for sending outbound e-mails. Remember that for the best
# e-mail delivery external IP should match the hostname it resolves to.

NAME='postfix'
DATA_ROOT='/srv'
POSTFIX_DATA="${DATA_ROOT}/${NAME}/data"
POSTFIX_LOG="${DATA_ROOT}/${NAME}/log"

export MAILNAME='temporary.example.com'
export MY_NETWORKS='172.17.0.0/16 127.0.0.0/8'
export ROOT_ALIAS='somebody@example.com'
export MY_DESTINATION='localhost.localdomain localhost'

mkdir -p "$POSTFIX_DATA"
mkdir -p "$POSTFIX_LOG"

docker stop "${NAME}" || true
sleep 1
docker rm "${NAME}" || true
sleep 1
docker run --detach=true --restart=always --name "${NAME}" --hostname "${MAILNAME}" --env MAILNAME --env MY_NETWORKS --env ROOT_ALIAS --env MY_DESTINATION --volume "${POSTFIX_LOG}:/var/log/postfix" --volume "${POSTFIX_DATA}:/var/spool/postfix" tozd/postfix
