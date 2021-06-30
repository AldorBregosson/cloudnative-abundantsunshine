#!/usr/local/bin/bash
# loads data into the deployed database(s)
# this must be done in a local CLI terminal window, as these services are not exposed.
#
# This command may be of help (from the 'outside', as there is no kubectl command 'inside'):
# connections_cluster_ip=$(kubectl get svc connections-svc -ojsonpath='{.spec.clusterIP}')
# echo $connections_cluster_ip
# posts_cluster_ip=$(kubectl get svc posts-svc -ojsonpath='{.spec.clusterIP}')
# echo $posts_cluster_ip
# or:
# connections_cluster_ip=$(kubectl get services/connections-svc -o go-template='{{(.spec.clusterIP)}}')
# see https://stackoverflow.com/questions/55065314/how-to-get-the-cluster-ip-of-a-kubernetes-service
#
curl -X POST -H "Content-Type:application/json" --data '{"name":"Cornelia","username":"cdavisafc"}' $(minikube service connections-svc --format "{{.IP}}"):$(minikube service connections-svc --format "{{.Port}}")/users
curl -X POST -H "Content-Type:application/json" --data '{"name":"Max","username":"madmax"}' $(minikube service connections-svc --format "{{.IP}}"):$(minikube service connections-svc --format "{{.Port}}")/users
curl -X POST -H "Content-Type:application/json" --data '{"name":"Glen","username":"gmaxdavis"}' $(minikube service connections-svc --format "{{.IP}}"):$(minikube service connections-svc --format "{{.Port}}")/users

sleep 5

curl -X POST -H "Content-Type:application/json" --data '{"follower":"madmax","followed":"cdavisafc"}' $(minikube service connections-svc --format "{{.IP}}"):$(minikube service connections-svc --format "{{.Port}}")/connections
curl -X POST -H "Content-Type:application/json" --data '{"follower":"cdavisafc","followed":"madmax"}' $(minikube service connections-svc --format "{{.IP}}"):$(minikube service connections-svc --format "{{.Port}}")/connections
curl -X POST -H "Content-Type:application/json" --data '{"follower":"cdavisafc","followed":"gmaxdavis"}' $(minikube service connections-svc --format "{{.IP}}"):$(minikube service connections-svc --format "{{.Port}}")/connections

sleep 5

curl -X POST -H "Content-Type:application/json" --data '{"username":"madmax","title":"Chicken Pho","body":"This is my attempt to recreate what I ate in Vietnam..."}' $(minikube service posts-svc --format "{{.IP}}"):$(minikube service posts-svc --format "{{.Port}}")/posts
curl -X POST -H "Content-Type:application/json" --data '{"username":"cdavisafc","title":"Whole Orange Cake","body":"That'\''s right, you blend up whole oranges, rind and all..."}' $(minikube service posts-svc --format "{{.IP}}"):$(minikube service posts-svc --format "{{.Port}}")/posts
curl -X POST -H "Content-Type:application/json" --data '{"username":"cdavisafc","title":"German Dumplings (Kloesse)","body":"Russet potatoes, flour (gluten free!) and more..."}' $(minikube service posts-svc --format "{{.IP}}"):$(minikube service posts-svc --format "{{.Port}}")/posts
curl -X POST -H "Content-Type:application/json" --data '{"username":"gmaxdavis","title":"French Press Lattes","body":"We'\''ve figured out how to make these dairy free, but just as good!..."}' $(minikube service posts-svc --format "{{.IP}}"):$(minikube service posts-svc --format "{{.Port}}")/posts

