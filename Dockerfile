FROM stain/jena-fuseki

ENV FUSEKI_BASE /fuseki-base

COPY spatial-arq-1.0.0-SNAPSHOT-with-dependencies.jar /javalibs/
COPY silk-arq-1.0.0-SNAPSHOT-with-dependencies.jar /javalibs/

COPY fuseki-config.ttl $FUSEKI_BASE/config.ttl

RUN mkdir $FUSEKI_BASE/configuration

# Set permissions to allow fuseki to run as an arbitrary user
RUN chgrp -R 0 $FUSEKI_BASE \
    && chmod -R g+rwX $FUSEKI_BASE

EXPOSE 3030

USER 9008

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java", "-cp", "*:/javalibs/*", "org.apache.jena.fuseki.cmd.FusekiCmd"]