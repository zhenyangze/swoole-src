#!/bin/sh
__CURRENT__=`pwd`
__DIR__=$(cd "$(dirname "$0")";pwd)
DOCKER_COMPOSE_VERSION="1.21.0"

#------------Only run once-------------
if [ "`php -v | grep "PHP 7\\.2"`" ]; then
    echo "run phpt in docker...\n"
    set -e
    curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose && \
    chmod +x docker-compose && \
    sudo mv docker-compose /usr/local/bin && \
    docker-compose -v && \
    docker -v && \
    cd ${__DIR__} && \
    mkdir data && \
    mkdir data/mysql && \
    mkdir data/redis && \
    chmod -R 777 data && \
    docker-compose up -d && \
    docker ps && \
    docker exec travis_php_1 /swoole-src/travis/docker-all.sh
else
    echo "skip\n"
fi