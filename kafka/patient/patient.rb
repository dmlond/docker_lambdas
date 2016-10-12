#!/usr/local/bin/ruby
def interact(prompt)
  $stdout.puts prompt
  $stdout.print "> "
  @problem = $stdin.gets.chomp
  report(@problem)
end

def report(problem)
  @producer.produce(problem, topic: @topic)
  @producer.deliver_messages
end

require 'kafka'

@topic = 'patient'
@other_topic = 'dockter'
kafka = Kafka.new(seed_brokers: ["kafka:9092"])
@producer = kafka.producer
interact("Please describe your problem?")
consumer = kafka.consumer(group_id: "patient")
consumer.subscribe(@other_topic)
consumer.each_message do |message|
  interact( message.value )
end
