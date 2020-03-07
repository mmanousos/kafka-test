require 'kafka'

# These commands are all from kafka-ruby for setting up a consumer
kafka = Kafka.new(["localhost:9092"])
consumer = kafka.consumer(group_id: "apple-consumer")
consumer.subscribe("apple")
# trap("TERM") { consumer.stop } 

# This will loop indefinitely, yielding each message in turn.
consumer.each_message do |message|
  puts ''
  puts 'this is the current Apple stock data'
  puts "topic: #{message.topic}, partition: #{message.partition}"
  puts "offset: #{message.offset}, key: #{message.key}, value: #{message.value}"
end