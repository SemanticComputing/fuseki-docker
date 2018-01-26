# Fuseki

Apache Jena Fuseki with SeCo extensions.

## Build

`docker build --squash -t secoresearch/fuseki .`

## Run

`docker run --rm -it -p 3030:3030 --name fuseki -e ADMIN_PASSWORD=[PASSWORD] secoresearch/fuseki`