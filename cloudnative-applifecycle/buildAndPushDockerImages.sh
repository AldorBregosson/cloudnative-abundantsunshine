#!/usr/local/bin/bash
docker build --build-arg \
jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-applifecycle-connectionposts:0.0.2 .
#
docker build --build-arg \
jar_file=cloudnative-connections/target/cloudnative-connections-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-applifecycle-connections:0.0.2 .
#
docker build --build-arg \
jar_file=cloudnative-posts/target/cloudnative-posts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-applifecycle-posts:0.0.2 .
#
docker push aldorbregosson/cloudnative-applifecycle-connectionposts:0.0.2
docker push aldorbregosson/cloudnative-applifecycle-connections:0.0.2
docker push aldorbregosson/cloudnative-applifecycle-posts:0.0.2
