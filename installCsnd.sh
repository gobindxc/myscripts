#!/bin/bash
# create cassandra database in AWS ec2 machine with terraform 
sudo su -
sudo dnf install -y  java-1.8.0-openjdk-devel python2
sudo alternatives --auto --config java
sleep 10
cat <<EOF >> /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF
cd 
sleep 10
sudo dnf install -y  cassandra
cat <<EOF >> /etc/systemd/system/cassandra.service
[Unit]
Description=Apache Cassandra
After=network.target

[Service]
PIDFile=/var/run/cassandra/cassandra.pid
User=cassandra
Group=cassandra
ExecStart=/usr/sbin/cassandra -f -p /var/run/cassandra/cassandra.pid
Restart=always

[Install]
WantedBy=multi-user.target
EOF
sleep 10
sudo systemctl start cassandra
sleep 30 
sudo systemctl status cassandra
sleep 10
sudo systemctl enable cassandra
sleep 10


