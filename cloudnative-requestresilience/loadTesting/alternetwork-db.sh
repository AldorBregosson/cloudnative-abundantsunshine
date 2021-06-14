#!/usr/local/bin/bash
if [ $1 == "add" ]; then
    action="breaking"
else
    action="fixing"
fi
echo "$action 5 connections"
kubectl exec mysql-698d9857bc-hh9cq -- route $1 -host 172.17.0.12 reject
kubectl exec mysql-698d9857bc-hh9cq -- route $1 -host 172.17.0.13 reject
kubectl exec mysql-698d9857bc-hh9cq -- route $1 -host 172.17.0.14 reject
kubectl exec mysql-698d9857bc-hh9cq -- route $1 -host 172.17.0.15 reject

