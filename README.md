# Fuseki

Apache Jena Fuseki with SeCo extensions.

Available also in Docker Hub: [secoresearch/fuseki](https://hub.docker.com/r/secoresearch/fuseki/)

## Build

`docker build --squash -t secoresearch/fuseki .`

## Run

`docker run --rm -it -p 3030:3030 --name fuseki -e ADMIN_PASSWORD=[PASSWORD] secoresearch/fuseki`
