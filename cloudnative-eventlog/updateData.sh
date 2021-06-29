#!/usr/local/bin/bash
# updates some user data (locally)
curl -X PUT -H "Content-Type:application/json" --data '{"name":"Cornelia","username":"cdavisafc2"}' localhost:8082/users/cdavisafc

curl -X DELETE localhost:8082/connections/cdavisafc/gmaxdavis

