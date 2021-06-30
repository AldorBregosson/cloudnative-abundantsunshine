#!/usr/bin/bash
# loads data into the deployed database(s)
# this must be done in a local CLI terminal window, as these services are not exposed.
# The Cluster IP address of the services in use must be determined each time the
# environment is started aner using
# kubectl get services
curl -X POST -H "Content-Type:application/json" --data '{"name":"Cornelia","username":"cdavisafc"}' 10.99.56.109:80/users
curl -X POST -H "Content-Type:application/json" --data '{"name":"Max","username":"madmax"}' 10.99.56.109:80/users
curl -X POST -H "Content-Type:application/json" --data '{"name":"Glen","username":"gmaxdavis"}' 10.99.56.109:80/users

sleep 5

curl -X POST -H "Content-Type:application/json" --data '{"follower":"madmax","followed":"cdavisafc"}' 10.99.56.109:80/connections
curl -X POST -H "Content-Type:application/json" --data '{"follower":"cdavisafc","followed":"madmax"}' 10.99.56.109:80/connections
curl -X POST -H "Content-Type:application/json" --data '{"follower":"cdavisafc","followed":"gmaxdavis"}' 10.99.56.109:80/connections

sleep 5

curl -X POST -H "Content-Type:application/json" --data '{"username":"madmax","title":"Chicken Pho","body":"This is my attempt to recreate what I ate in Vietnam..."}' 10.106.210.253:80/posts
curl -X POST -H "Content-Type:application/json" --data '{"username":"cdavisafc","title":"Whole Orange Cake","body":"That'\''s right, you blend up whole oranges, rind and all..."}' 10.106.210.253:80/posts
curl -X POST -H "Content-Type:application/json" --data '{"username":"cdavisafc","title":"German Dumplings (Kloesse)","body":"Russet potatoes, flour (gluten free!) and more..."}' 10.106.210.253:80/posts
curl -X POST -H "Content-Type:application/json" --data '{"username":"gmaxdavis","title":"French Press Lattes","body":"We'\''ve figured out how to make these dairy free, but just as good!..."}' 10.106.210.253:80/posts

