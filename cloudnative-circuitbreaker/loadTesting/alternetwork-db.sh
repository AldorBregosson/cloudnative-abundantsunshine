#!/usr/local/bin/bash
if [ $1 == "add" ]; then
    action="breaking"
else
    action="fixing"
fi

echo "$action connections between posts and mysql"
kubectl exec mysql-698d9857bc-mz948 -- route $1 -host 172.17.0.13 reject
kubectl exec mysql-698d9857bc-mz948 -- route $1 -host 172.17.0.14 reject
kubectl exec mysql-698d9857bc-mz948 -- route $1 -host 172.17.0.15 reject
kubectl exec mysql-698d9857bc-mz948 -- route $1 -host 172.17.0.16 reject

