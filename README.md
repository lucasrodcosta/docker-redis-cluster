Redis Cluster with Interval Sets
--------------

A Redis Cluster with 6 instances (3 master and 3 slaves, one slave for each master). They run on ports 7000 to 7005.

The main usage for this container is to test Redis Cluster with the patch for Interval Sets.  
To more info about this version of Redis, please check [this repository](https://github.com/lucasrodcosta/redis).

Docker Hub
--------------
https://hub.docker.com/r/lucasrodcosta/redis-cluster/


Note for Mac users
--------------
If you are using this container to run a Redis Cluster on your Mac computer, then you need to configure the container to use another IP address for cluster discovery.

```
docker run -e "IP=0.0.0.0" lucasrodcosta/redis-cluster:4.0.8-interval-sets
```
