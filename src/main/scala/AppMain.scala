import kafka.serializer.StringDecoder
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.{ SparkContext, SparkConf }
import org.apache.spark.streaming.{ Seconds, StreamingContext }

object AppMain {
  def main(args: Array[String]) {

    val conf = new SparkConf().setAppName("demoapp").setMaster("local[*]")
    val sc = new SparkContext(conf)
    val ssc = new StreamingContext(sc, Seconds(2))

    val kafkaConfig = Map("metadata.broker.list" -> "localhost:9092")
    val topics = Set("topic1")

    val wordstream = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](ssc, kafkaConfig, topics)
    val pairs = wordstream.map(word => (word, 1))
    val wordCounts = pairs.reduceByKey(_ + _)

    wordCounts.print()

    ssc.start()
    ssc.awaitTermination()
  }
}
