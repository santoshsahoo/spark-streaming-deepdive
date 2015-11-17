#/bin/bash

/usr/local/spark/sbin/start-master.sh
/usr/local/spark/sbin/start-slave.sh spark://localhost:7077

/usr/local/kafka/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties
