docker build --build-arg \
jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-requestresilience-connectionposts:0.0.1 .
#
docker build --build-arg \
jar_file=cloudnative-connections/target/cloudnative-connections-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-requestresilience-connections:0.0.1 .
#
docker build --build-arg \
jar_file=cloudnative-posts/target/cloudnative-posts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-requestresilience-posts:0.0.1 .
#
docker push aldorbregosson/cloudnative-requestresilience-connectionposts:0.0.1
docker push aldorbregosson/cloudnative-requestresilience-connections:0.0.1
docker push aldorbregosson/cloudnative-requestresilience-posts:0.0.1