export PATH="$PATH:/usr/local/spark/bin:/usr/local/spark/sbin:/usr/local/hadoop/bin:/usr/local/hadoop/sbin:/usr/local/kafka/bin"

kafka-topics.sh --zookeeper "localhost:2181" --create --topic topic1 --partitions 1 --replication-factor 1
kafka-topics.sh --zookeeper "localhost:2181" --list

kafka-console-producer.sh --property parse.key=true --property key.separator=: --broker-list "localhost:9092" --topic topic1

export $(cat .env | xargs)

spark-submit --class AppMain --master local[2] --jars $(cat distlib.txt) \
  ./build/libs/myproject.jar 'localhost:9092', 'topic1'

kafka-console-consumer.sh --zookeeper "localhost:2181" --topic topic1

spark-submit --class AppMain \
	--master local[2] \
	--jars $(cat distlib.txt)   \
	./build/libs/myproject.jar \
	'localhost:9092', 'topic1'
