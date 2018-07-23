#!/bin/sh

max_port=7005
ip=`hostname -i`

for port in `seq 7000 $max_port`; do
  mkdir -p /usr/src/redis/conf/${port}
  mkdir -p /usr/src/redis/data/${port}

  if [ -e /usr/src/redis/data/${port}/nodes.conf ]; then
    rm /usr/src/redis/data/${port}/nodes.conf
  fi

  PORT=${port} envsubst < /usr/src/redis/conf/redis-cluster.tmpl > /usr/src/redis/conf/${port}/redis.conf
done

sh /generate-supervisor-conf.sh $max_port > /etc/supervisor.d/redis.ini
supervisord
sleep 3

echo "yes" | ruby /usr/src/redis/src/redis-trib.rb create --replicas 1 ${ip}:7000 ${ip}:7001 ${ip}:7002 ${ip}:7003 ${ip}:7004 ${ip}:7005

tail -f /dev/null
