#!/usr/local/bin/bash
kubectl apply -f cookbook-deployment-connections.yaml
kubectl apply -f cookbook-deployment-posts.yaml
kubectl apply -f cookbook-deployment-connectionsposts.yaml