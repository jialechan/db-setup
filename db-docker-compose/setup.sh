#!/bin/bash

# 设置环境
sudo mkdir -p /data
sudo mkdir -p /data/elasticsearch  
sudo mkdir -p /data/mysql  
sudo mkdir -p /data/postgresql  
sudo mkdir -p /data/redis  
sudo mkdir -p /data/sonarqube
sudo chmod 777 -R /data



# 设置kafka host
cat <<EOF >./kafka-docker/.env
KAFKA_ADVERTISED_HOST_NAME=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
EOF

# 设置数据库密码
cat <<EOF >./mariadb-phpmyadmin-docker/.env
MYSQL_ROOT_PASSWORD=changeme
EOF

cat <<EOF >./redis-cluster-docker/redis-7000.conf
#该集群阶段的端口
port 7000
#为每一个集群节点指定一个pid_file
pidfile /var/run/redis_7000.pid
#在bind指令后添加本机的ip
bind 0.0.0.0
#找到Cluster配置的代码段，使得Redis支持集群
cluster-enabled yes
#每一个集群节点都有一个配置文件，这个文件是不能手动编辑的。确保每一个集群节点的配置文件不通
cluster-config-file nodes-7000.conf
#集群节点的超时时间，单位：ms，超时后集群会认为该节点失败
cluster-node-timeout 5000
#最后将appendonly改成yes
appendonly yes
EOF

cat <<EOF >./redis-cluster-docker/redis-7001.conf
#该集群阶段的端口
port 7001
#为每一个集群节点指定一个pid_file
pidfile /var/run/redis_7001.pid
#在bind指令后添加本机的ip
bind 0.0.0.0
#找到Cluster配置的代码段，使得Redis支持集群
cluster-enabled yes
#每一个集群节点都有一个配置文件，这个文件是不能手动编辑的。确保每一个集群节点的配置文件不通
cluster-config-file nodes-7001.conf
#集群节点的超时时间，单位：ms，超时后集群会认为该节点失败
cluster-node-timeout 5000
#最后将appendonly改成yes
appendonly yes
EOF

cat <<EOF >./redis-cluster-docker/redis-7002.conf
#该集群阶段的端口
port 7002
#为每一个集群节点指定一个pid_file
pidfile /var/run/redis_7002.pid
#在bind指令后添加本机的ip
bind 0.0.0.0
#找到Cluster配置的代码段，使得Redis支持集群
cluster-enabled yes
#每一个集群节点都有一个配置文件，这个文件是不能手动编辑的。确保每一个集群节点的配置文件不通
cluster-config-file nodes-7002.conf
#集群节点的超时时间，单位：ms，超时后集群会认为该节点失败
cluster-node-timeout 5000
#最后将appendonly改成yes
appendonly yes
EOF

cat <<EOF >./redis-cluster-docker/redis-7003.conf
#该集群阶段的端口
port 7003
#为每一个集群节点指定一个pid_file
pidfile /var/run/redis_7003.pid
#在bind指令后添加本机的ip
bind 0.0.0.0
#找到Cluster配置的代码段，使得Redis支持集群
cluster-enabled yes
#每一个集群节点都有一个配置文件，这个文件是不能手动编辑的。确保每一个集群节点的配置文件不通
cluster-config-file nodes-7003.conf
#集群节点的超时时间，单位：ms，超时后集群会认为该节点失败
cluster-node-timeout 5000
#最后将appendonly改成yes
appendonly yes
EOF

cat <<EOF >./redis-cluster-docker/redis-7004.conf
#该集群阶段的端口
port 7004
#为每一个集群节点指定一个pid_file
pidfile /var/run/redis_7004.pid
#在bind指令后添加本机的ip
bind 0.0.0.0
#找到Cluster配置的代码段，使得Redis支持集群
cluster-enabled yes
#每一个集群节点都有一个配置文件，这个文件是不能手动编辑的。确保每一个集群节点的配置文件不通
cluster-config-file nodes-7004.conf
#集群节点的超时时间，单位：ms，超时后集群会认为该节点失败
cluster-node-timeout 5000
#最后将appendonly改成yes
appendonly yes
EOF

cat <<EOF >./redis-cluster-docker/redis-7005.conf
#该集群阶段的端口
port 7005
#为每一个集群节点指定一个pid_file
pidfile /var/run/redis_7005.pid
#在bind指令后添加本机的ip
bind 0.0.0.0
#找到Cluster配置的代码段，使得Redis支持集群
cluster-enabled yes
#每一个集群节点都有一个配置文件，这个文件是不能手动编辑的。确保每一个集群节点的配置文件不通
cluster-config-file nodes-7005.conf
#集群节点的超时时间，单位：ms，超时后集群会认为该节点失败
cluster-node-timeout 5000
#最后将appendonly改成yes
appendonly yes
EOF

cd redis-cluster-docker/redis-6.0.3
make MALLOC=libc
cd ../../
