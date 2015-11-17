/usr/local/kafka/bin/kafka-topics.sh --zookeeper "localhost:2181" --create --topic topic1 --partitions 1 --replication-factor 1
/usr/local/kafka/bin/kafka-topics.sh --zookeeper "localhost:2181" --list

export $(cat .env | xargs)

export PATH="$PATH:/usr/local/spark/bin:/usr/local/spark/sbin:/usr/local/hadoop/bin:/usr/local/hadoop/sbin:/usr/local/kafka/bin"
spark-submit --class AppMain --master local[2] --jars $(cat distlib.txt) ./build/libs/myproject.jar
