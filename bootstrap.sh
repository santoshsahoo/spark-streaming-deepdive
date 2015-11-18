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

su - vagrant -c 'echo -e  "y\n" | ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'
cat /home/vagrant/.ssh/id_rsa.pub > .ssh/authorized_keys

pip install kafka-python
