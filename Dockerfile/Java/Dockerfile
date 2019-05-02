FROM java:8

COPY docker-entrypoint.sh /usr/local/bin/

RUN apt update && apt install maven && ln -s usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]

