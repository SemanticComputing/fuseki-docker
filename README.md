# Fuseki

Apache [Jena Fuseki](https://jena.apache.org/documentation/fuseki2/index.html) with SeCo extensions.

Available also in Docker Hub: [secoresearch/fuseki](https://hub.docker.com/r/secoresearch/fuseki/).

The Fuseki administrative interface is accessible at `http://localhost:3030` with the admin password defined as `docker run` parameter (see `Run` below).

The container has a preconfigured service/dataset `ds` that has a Lucene [text index](https://jena.apache.org/documentation/query/text-query.html) and [spatial index](https://jena.apache.org/documentation/query/spatial-query.html) (see [assembler.ttl](https://github.com/SemanticComputing/fuseki-docker/blob/master/assembler.ttl) for configuration).

The data can be accessed via the endpoints:
* [SPARQL 1.1 query](https://www.w3.org/TR/sparql11-query/): `http://localhost:3030/ds/sparql`
* [Graph Store HTTP Protocol](https://www.w3.org/TR/sparql11-http-rdf-update/) (read-only): `http://localhost:3030/ds/data`

The container includes Jena tdbloader, textindexer, spatialindexer, and tdbstats scripts for loading RDF data into TDB model. See the [Dockerfile of the congress-legislators dataset](https://github.com/SemanticComputing/congress-legislators/blob/master/Dockerfile) for an example.

## Build

`docker build --squash -t secoresearch/fuseki .`

## Run

`docker run --rm -it -p 3030:3030 --name fuseki -e ADMIN_PASSWORD=[PASSWORD] secoresearch/fuseki`

The same command can be used to pull and run the container from Docker Hub (no need to build the image first).
