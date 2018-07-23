FROM ruby:2.5-alpine

RUN apk add --no-cache \
    gettext \
    supervisor

RUN gem install redis -v 3.3.3

ENV REDIS_DOWNLOAD_URL "https://github.com/lucasrodcosta/redis/archive/4.0.8-interval-sets.tar.gz"

RUN apk add --no-cache --virtual .build-deps build-base linux-headers \
    && wget -qO redis.tar.gz ${REDIS_DOWNLOAD_URL} \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && rm redis.tar.gz \
    && cd /usr/src/redis/src \
    && make \
    && apk del .build-deps

RUN mkdir /usr/src/redis/conf \
    /usr/src/redis/data \
    /etc/supervisor.d

COPY ./redis-cluster.tmpl /usr/src/redis/conf/redis-cluster.tmpl
COPY ./generate-supervisor-conf.sh /generate-supervisor-conf.sh

COPY ./run.sh /run.sh

EXPOSE 7000 7001 7002 7003 7004 7005

CMD ["/run.sh"]
