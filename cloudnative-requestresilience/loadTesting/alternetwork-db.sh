#!/usr/local/bin/bash
# a parameter is required, otherwise bash complains with
# 'loadTesting/alternetwork-db.sh: line 2: [: ==: unary operator expected'
if [ -z "$1" ]; then
  echo "usage: alternetwork-db.sh add | alternetwork-db.sh delete"
  exit
fi
if [ $1 == "add" ]; then
    action="breaking"
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.13 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.14 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.15 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.16 reject
fi
if [ $1 == "delete" ]; then
    action="fixing"
    # we may want to add commands for fixing the network connections again:
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.16 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.15 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.14 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.13 reject
fi
# actually, it's FOUR connections from posts instances to the database.
echo "$action 4 connections"
