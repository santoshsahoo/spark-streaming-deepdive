import kafka.serializer.StringDecoder
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.{SparkContext, SparkConf}
import org.apache.spark.streaming.{Seconds, StreamingContext}

object AppMain {
  def main(args: Array[String]) {
    val (broker, topic) = (args(0), args(1))

    val conf = new SparkConf().setAppName("demoapp")
    val sc = new SparkContext(conf)
    val ssc = new StreamingContext(sc, Seconds(2))

    val kafkaConfig = Map("metadata.broker.list" -> broker)
    val topics = topic.split(",").toSet

    val wordstream = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](ssc, kafkaConfig, topics)
    val pairs = wordstream.map(entry => (entry._1, 1))
    val wordCounts = pairs.reduceByKey(_ + _)
    val trend = wordCounts.transform(rdd => rdd.sortBy(_._2, false))

    trend.print()

//    val anotherTopic = Set("topic2")
//    val wordstream2 = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](ssc, kafkaConfig, anotherTopic)
//    wordstream2.print()

    ssc.start()
    ssc.awaitTermination()
  }
}
