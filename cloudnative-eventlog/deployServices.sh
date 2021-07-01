#!/usr/local/bin/bash
kubectl apply -f mysql-deployment.yaml
# after creating mysql must create the cookbook databases:
# mysql> create database cookbookconnectionsposts;
# mysql> create database cookbookposts;
# mysql> create database cookbookconnections;
kubectl apply -f zookeeper-deployment.yaml
kubectl apply -f kafka-deployment.yaml

