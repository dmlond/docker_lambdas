#!/bin/sh
kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic dockter
kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic patient
kafka-topics.sh --zookeeper zookeeper:2181 --list
exit
