A sample workflow of using Docker Containers to run a Kafka producer and consumer to view Apple stock prices in real time.

### Tools used 
* Docker Compose for simultaneously launching separate Docker Containers
* Apache Zookeeper and Apache Kafka
* [Ruby-Kafka gem](https://github.com/zendesk/ruby-kafka)
* [AlphaVantage API](https://www.alphavantage.co/documentation/) and [AlphaVantageRB gem](https://github.com/StefanoMartin/AlphaVantageRB)
* [Timeloop gem](https://github.com/pinoss/timeloop) to publish messages to the kafka topic at a set interval (at pace with when the updated streaming data is available)

### Instructions 

navigate into the producer directory 
`$ cd producer`
then install the Ruby dependencies
`$ bundle install`

repeat in the consumer directory

#### To see the Kafka data in action

You will need to open 3 terminal windows.
All commands should be issued from within the root project directory.

1. first window: run Docker Compose to set up the Zookeeper instance and sets up the Kafka cluster along with the "Apple" topic, 3 partitions and 1 replica for fault tolerance
`$ docker-compose up`

2. second window: launch the producer script to publish the data to the kafka message topic
`$ ruby ./producer/src/producer.rb`

3. third window: launch the consumer script to view the data from the kafka topic
`$ ruby ./consumer/src/consumer.rb`

#### To terminate the processes
`$ CTRL + C` in each terminal window