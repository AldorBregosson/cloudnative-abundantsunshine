#!/usr/local/bin/bash
#
# build and push the docker images, adapted for aldorbregosson.
#     by sbu : 2021-05-11
# last change: 2021-11-13  (stateless version of connectionposts)
# -----------------------------------------------------------------------------
docker build --build-arg \
jar_file=cloudnative-connections/target/cloudnative-connections-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-statelessness-connections .
#
docker build --build-arg \
jar_file=cloudnative-posts/target/cloudnative-posts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-statelessness-posts .
#
docker push aldorbregosson/cloudnative-statelessness-connections
docker push aldorbregosson/cloudnative-statelessness-posts

# Two different versions of connectionposts - and get rid of that dratted 's'.
# 1. the stateful version
#docker build --build-arg \
#jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
#-t aldorbregosson/cloudnative-statelessness-connectionposts-stateful .
#
#docker push aldorbregosson/cloudnative-statelessness-connectionposts-stateful
#
# 2. the stateless version
docker build --build-arg \
jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-statelessness-connectionposts-stateless .
#
docker push aldorbregosson/cloudnative-statelessness-connectionposts-stateless
