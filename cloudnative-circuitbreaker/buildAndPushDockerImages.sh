docker build --build-arg \
jar_file=cloudnative-posts/target/cloudnative-posts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-circuitbreaker-posts:0.0.1 .
#
docker push aldorbregosson/cloudnative-circuitbreaker-posts:0.0.1

