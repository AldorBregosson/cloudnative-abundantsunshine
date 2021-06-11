#!/usr/local/bin/bash
# a parameter is required, otherwise bash complains with
# 'loadTesting/alternetwork-db.sh: line 2: [: ==: unary operator expected'
if [ -z "$1" ]; then
  echo "usage: alternetwork-db.sh add | alternetwork-db.sh delete"
  exit
fi
if [ $1 == "add" ]; then
    action="breaking"
fi
if [ $1 == "delete" ]; then
    action="fixing"
fi
kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.6 reject
kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.7 reject
kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.8 reject
kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.9 reject
echo "$action 5 connections"

