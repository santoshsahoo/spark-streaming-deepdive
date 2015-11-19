#/bin/bash
cd /tmp

apt-get update
apt-get install openjdk-7-jdk -y python-pip

curl -O "http://d3kbcqa49mib13.cloudfront.net/spark-1.5.2-bin-hadoop2.6.tgz"
curl -O "http://www.gtlib.gatech.edu/pub/apache/hadoop/common/hadoop-2.6.2/hadoop-2.6.2.tar.gz"
curl -O "http://www.gtlib.gatech.edu/pub/apache/kafka/0.8.2.2/kafka_2.11-0.8.2.2.tgz"

tar -xf hadoop-2.6.2.tar.gz -C /usr/local
tar -xf spark-1.5.2-bin-hadoop2.6.tgz -C /usr/local
tar -xf kafka_2.11-0.8.2.2.tgz -C /usr/local

ln -fs /usr/local/hadoop-2.6.2/ /usr/local/hadoop
ln -fs /usr/local/spark-1.5.2-bin-hadoop2.6/ /usr/local/spark
ln -fs /usr/local/kafka_2.11-0.8.2.2/ /usr/local/kafka

echo "export JAVA_HOME='/usr/lib/jvm/java-7-openjdk-amd64'" > /etc/profile.d/jdk.sh
chmod +x /etc/profile.d/jdk.sh

echo "SPARK_LOCAL_IP='192.168.10.21'" > /usr/local/spark/conf/spark-env.sh

echo /usr/local/spark/conf/log4j.properties <<EOF
# Set everything to be logged to the console
log4j.rootCategory=WARN, console
log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.target=System.err
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%d{yy/MM/dd HH:mm:ss} %p %c{1}: %m%n

# Settings to quiet third party logs that are too verbose
log4j.logger.org.spark-project.jetty=WARN
log4j.logger.org.spark-project.jetty.util.component.AbstractLifeCycle=ERROR
log4j.logger.org.apache.spark.repl.SparkIMain$exprTyper=INFO
log4j.logger.org.apache.spark.repl.SparkILoop$SparkILoopInterpreter=INFO
log4j.logger.org.apache.parquet=ERROR
log4j.logger.parquet=ERROR

# SPARK-9183: Settings to avoid annoying messages when looking up nonexistent UDFs in SparkSQL with Hive support
log4j.logger.org.apache.hadoop.hive.metastore.RetryingHMSHandler=FATAL
log4j.logger.org.apache.hadoop.hive.ql.exec.FunctionRegistry=ERROR
EOF

su - vagrant -c 'echo -e  "y\n" | ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'
cat /home/vagrant/.ssh/id_rsa.pub > .ssh/authorized_keys

pip install kafka-python
