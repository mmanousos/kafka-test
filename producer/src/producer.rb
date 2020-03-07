require 'json'
require 'kafka'
require 'alphavantagerb'
require 'timeloop'

#  uses the Alphavantage API and gem to access real-time stock data
client = Alphavantage::Client.new key: 'B2ZFC9CWBMXE864Y'
# references Apple stock prices
stock = client.stock symbol: 'AAPL'

# connects to the local Kafka instance
kafka = Kafka.new(["localhost:9092"])

# uses the ruby-kafka library to set up an asyncronous producer
producer = kafka.async_producer

# uses the Timeloop library to set up an interval
Timeloop.every 60.seconds do
  # `timeseries` `.high` and the `type` and `interval` settings are from Alphavantage
  ts = stock.timeseries(type: 'intraday', interval: '1min')
  high = ts.high.first # `.first` retrieves the most recent entry from the timeseries data
  producer.produce(high, topic: "apple") # `.produce` is a method from the ruby-kafka library
  producer.deliver_messages              # `.deliver_messages` is another method from the ruby-kafka library
end

# producer.shutdown