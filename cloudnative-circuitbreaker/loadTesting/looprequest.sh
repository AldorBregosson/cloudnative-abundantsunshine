#!/usr/local/bin/bash
# do some requests in a loop.
for i in {1..5000}
do
   echo "$i: "
   curl -i -b cookie 127.0.0.1/connectionsposts
done
