# Fuseki

Apache [Jena Fuseki](https://jena.apache.org/documentation/fuseki2/index.html) with SeCo extensions.

Available in Docker Hub: [secoresearch/fuseki](https://hub.docker.com/r/secoresearch/fuseki/).

The Fuseki administrative interface is accessible at `http://localhost:3030` with the admin password defined as `docker run` parameter (see the `Run` section below).

The container has a preconfigured service/dataset `ds` that uses [TDB](https://jena.apache.org/documentation/tdb/) for data storage and has a Lucene [text index](https://jena.apache.org/documentation/query/text-query.html) and [spatial index](https://jena.apache.org/documentation/query/spatial-query.html) (see [assembler.ttl](https://github.com/SemanticComputing/fuseki-docker/blob/master/assembler.ttl) for configuration).

The query timeout is configured to 60 seconds by default (see the `Run` section below for instructions on configuration).

## Data access

The data can be accessed via the default endpoints:
* [SPARQL 1.1 query](https://www.w3.org/TR/sparql11-query/): `http://localhost:3030/ds/sparql`
* [Graph Store HTTP Protocol](https://www.w3.org/TR/sparql11-http-rdf-update/) (read-only): `http://localhost:3030/ds/data`

Other endpoints can be enabled, as well (see the Run section for instructions):
* [SPARQL 1.1 Update](https://www.w3.org/TR/sparql11-update/): `http://localhost:3030/ds/update`
* Graph Store HTTP Protocol with write access: `http://localhost:3030/ds/data`
* File Upload: `http://localhost:3030/ds/upload`

The container includes Jena tdbloader, textindexer, spatialindexer, and tdbstats scripts for loading RDF data into TDB model. See the [Dockerfile of the congress-legislators dataset](https://github.com/SemanticComputing/congress-legislators/blob/master/Dockerfile) for an example.

## Persistent storage

There are two options for persistent data storage (by default the data is lost when the container is removed):

1. Use volume/bind mount for the directory `/fuseki-base/databases`. Useful if you need to update the data in runtime, or you don't want to include the data inside your Docker image (e.g. to keep the image size small; see the `Run` section below for an example).
2. Create your own Dockerfile, using secoresearch/fuseki as a parent image, and load the data in the build phase (i.e. the data is included in the Docker image). Useful for static, small(ish), read-only datasets, and for distributing your dataset + Fuseki as a self-contained container image. See the [Dockerfile of the congress-legislators dataset](https://github.com/SemanticComputing/congress-legislators/blob/master/Dockerfile) for an example.

**Note on running in OpenShift**, if you use this image as a parent image (e.g. use your own Dockerfile to load the data inside the image using TDBLOADER): as containers are run as an arbitrary user, you'll have to ensure the write permission on the TDB and index directories, e.g. by adding the following lines in your Dockerfile after the tdbloader and indexing commands:

```
# Set permissions to allow fuseki to run as an arbitrary user
RUN chgrp -R 0 $FUSEKI_BASE \
    && chmod -R g+rwX $FUSEKI_BASE
```

## Build

`docker build --squash -t secoresearch/fuseki .`

## Run

`docker run --rm -it -p 3030:3030 --name fuseki -e ADMIN_PASSWORD=[PASSWORD] -e ENABLE_DATA_WRITE=[true|false] -e ENABLE_UPDATE=[true|false] -e ENABLE_UPLOAD=[true|false] -e QUERY_TIMEOUT=[number in milliseconds] --mount type=bind,source="$(pwd)"/fuseki-data,target=/fuseki-base/databases secoresearch/fuseki`

The same run command can be used to pull and run the container from Docker Hub (no need to build the image first).
