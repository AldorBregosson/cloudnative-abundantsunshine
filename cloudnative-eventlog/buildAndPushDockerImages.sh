docker build --build-arg \
jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-eventlog-connectionposts:0.0.2 .
#
docker build --build-arg \
jar_file=cloudnative-connections/target/cloudnative-connections-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-eventlog-connections:0.0.2 .
#
docker build --build-arg \
jar_file=cloudnative-posts/target/cloudnative-posts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-eventlog-posts:0.0.2 .
#
docker push aldorbregosson/cloudnative-eventlog-connectionposts:0.0.2
docker push aldorbregosson/cloudnative-eventlog-connections:0.0.2
docker push aldorbregosson/cloudnative-eventlog-posts:0.0.2

