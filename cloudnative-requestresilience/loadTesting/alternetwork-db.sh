#!/usr/local/bin/bash
if [ $1 == "add" ]; then
    action="breaking"
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.13 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.14 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.15 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route $1 -host 172.17.0.16 reject
else
    action="fixing"
    # we may want to add commands for fixing the network connections again:
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.16 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.15 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.14 reject
    kubectl exec mysql-698d9857bc-rk9l8 -- route delete -host 172.17.0.13 reject
fi
echo "$action 5 connections"
