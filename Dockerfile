FROM stain/jena-fuseki

MAINTAINER Jouni Tuominen <jouni.tuominen@aalto.fi>

# The parent image declares /fuseki as a volume, so it permissions cannot be changed
# here, so we use /fuseki-base as the base directory
ENV FUSEKI_BASE /fuseki-base

COPY spatial-arq-1.0.0-SNAPSHOT-with-dependencies.jar /javalibs/
COPY silk-arq-1.0.0-SNAPSHOT-with-dependencies.jar /javalibs/

COPY fuseki-config.ttl $FUSEKI_BASE/config.ttl
COPY assembler.ttl $FUSEKI_BASE/configuration/assembler.ttl

# Set permissions to allow fuseki to run as an arbitrary user
RUN chgrp -R 0 $FUSEKI_BASE \
    && chmod -R g+rwX $FUSEKI_BASE

EXPOSE 3030

USER 9008

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-cp", "*:/javalibs/*", "org.apache.jena.fuseki.cmd.FusekiCmd"]