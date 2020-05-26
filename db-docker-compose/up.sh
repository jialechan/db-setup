#!/bin/bash

cd mariadb-phpmyadmin-docker
sudo docker-compose up -d
cd .. 

cd elk-docker 
sudo docker-compose up -d
cd ..

cd kafka-docker
sudo docker-compose up -d
cd ..

cd redis-docker
sudo docker-compose up -d
cd ..

cd sonar-docker
sudo docker-compose up -d
cd ..

cd redis-cluster-docker
export LOCAL_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
nohup redis-6.0.3/src/redis-server redis-7000.conf &
nohup redis-6.0.3/src/redis-server redis-7001.conf &
nohup redis-6.0.3/src/redis-server redis-7002.conf &
nohup redis-6.0.3/src/redis-server redis-7003.conf &
nohup redis-6.0.3/src/redis-server redis-7004.conf &
nohup redis-6.0.3/src/redis-server redis-7005.conf &
sleep 10
redis-6.0.3/src/redis-cli --cluster create $LOCAL_IP:7000 $LOCAL_IP:7001 $LOCAL_IP:7002 $LOCAL_IP:7003 $LOCAL_IP:7004 $LOCAL_IP:7005 --cluster-replicas 1 
cd ..
