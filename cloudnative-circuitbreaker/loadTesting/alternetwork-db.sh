#!/usr/local/bin/bash
if [ $1 == "add" ]; then
    action="breaking"
else
    action="fixing"
fi

echo "$action connections between posts and mysql"
kubectl exec mysql-7496bdd68f-9vrgh -- route $1 -host 172.17.0.6 reject
kubectl exec mysql-7496bdd68f-9vrgh -- route $1 -host 172.17.0.7 reject
kubectl exec mysql-7496bdd68f-9vrgh -- route $1 -host 172.17.0.8 reject
kubectl exec mysql-7496bdd68f-9vrgh -- route $1 -host 172.17.0.9 reject

