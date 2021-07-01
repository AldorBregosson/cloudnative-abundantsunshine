#!/usr/local/bin/bash

# delete the deployments of the microservices that make up our application.
kubectl delete deploy/posts
kubectl delete deploy/connections
kubectl delete deploy/connectionsposts

if [ "$1" = "all" ]; then
  # delete the deployments of basic services
  kubectl delete deploy/mysql
#  kubectl delete deploy/redis   # redis not used in this deployment.
#  kubectl delete deploy/sccs    # sccs not used in this deployment.
  kubectl delete deploy/kafka
  kubectl delete deploy/zookeeper

  # delete the eventlog services
  kubectl delete service/kafka-svc
  kubectl delete service/zoo
  # delete the microservices that make up our application.
  kubectl delete service/connectionsposts-svc
  kubectl delete service/connections-svc
  kubectl delete service/posts-svc
  kubectl delete service/mysql-svc
else
  echo "mysql, redis and other services may still be running"
fi

