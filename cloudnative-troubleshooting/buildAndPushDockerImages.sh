docker build --build-arg \
jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-troubleshooting-connectionposts .
#
docker build --build-arg \
jar_file=cloudnative-connections/target/cloudnative-connections-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-troubleshooting-connections .
#
docker build --build-arg \
jar_file=cloudnative-posts/target/cloudnative-posts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-troubleshooting-posts .
#
docker push aldorbregosson/cloudnative-troubleshooting-connectionposts
docker push aldorbregosson/cloudnative-troubleshooting-connections
docker push aldorbregosson/cloudnative-troubleshooting-posts