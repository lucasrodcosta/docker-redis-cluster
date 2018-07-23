#!/bin/sh

max_port="$1"

program_entry_template ()
{
  local count=$1
  local port=$2
  echo "

[program:redis-$count]
command=/usr/src/redis/src/redis-server /usr/src/redis/conf/$port/redis.conf
stdout_logfile=/dev/stdout
stderr_logfile=/dev/stderr
autorestart=true
"
}

result_str=""
count=1
for port in `seq 7000 $max_port`; do
  result_str="$result_str$(program_entry_template $count $port)"
  count=$((count + 1))
done

echo "$result_str"
