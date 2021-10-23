class Mqtt
  Thread.new do
    require 'mqtt'
      
    client = MQTT::Client.connect(
      host: 'localhost',
      port: 1883
    )
  
    client.subscribe( 'topic1' )
  
    client.get do |topic, message|
      PrometheusMetricSenderService.new(topic, message.to_f, 'iot').execute
    end
  end
end
