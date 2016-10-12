#!/usr/local/bin/ruby
def report(problem)
  @producer.produce(problem, topic: @topic)
  @producer.deliver_messages
end

def outsource_dockter(patient_query)
  container = Docker::Container.create('Image' => 'dockter', 'OpenStdin' => true, 'StdinOnce' => true)
  resp, error_messages = container.tap(&:start).attach(stdin: StringIO.new("#{patient_query}\n"))
  $stderr.puts "GOT ERRORS #{error_messages.join("\n")}"
  container.remove
  resp.join('')
end

require 'kafka'
require 'docker'

@topic = 'dockter'
@other_topic = 'patient'
kafka = Kafka.new(seed_brokers: ["kafka:9092"])
@producer = kafka.producer
consumer = kafka.consumer(group_id: "dockter")
consumer.subscribe(@other_topic)

consumer.each_message do |message|
  patient_query = "#{message.value}"
  prescription = outsource_dockter patient_query
  report(prescription)
end
