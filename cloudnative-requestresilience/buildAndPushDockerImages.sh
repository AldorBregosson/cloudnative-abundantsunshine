docker build --build-arg \
jar_file=cloudnative-connectionposts/target/cloudnative-connectionposts-0.0.1-SNAPSHOT.jar \
-t aldorbregosson/cloudnative-requestresilience-connectionposts:0.0.2 .
# only connections posts has changed for this step
#
docker push aldorbregosson/cloudnative-requestresilience-connectionposts:0.0.2
