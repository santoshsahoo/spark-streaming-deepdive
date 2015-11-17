import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.{SparkContext, SparkConf}
import org.apache.spark.streaming.{Seconds, StreamingContext}

object AppMain{
  def main (args: Array[String]) {

    val conf = new SparkConf().setAppName("demoapp").setMaster("local[1]")
    val sc = new SparkContext(conf)
    val ssc = new StreamingContext(sc, Seconds(2))

    val kafkaConfig = Map("metadata.broker.list"->"localhost:9092")
    val topics = Set("topic1")

    val dstream = KafkaUtils.createDirectStream(ssc, kafkaConfig, topics )
    dstream.print()

    ssc.start()
    ssc.awaitTermination()

  }
}
