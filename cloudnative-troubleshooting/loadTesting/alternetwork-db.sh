#!/usr/local/bin/bash
if [ $1 == "add" ]; then
    action="breaking"
else
    action="fixing"
fi

echo "$action connections between posts and mysql"
kubectl exec mysql-698d9857bc-4jfnq -- route $1 -host 172.17.0.11 reject
kubectl exec mysql-698d9857bc-4jfnq -- route $1 -host 172.17.0.12 reject

