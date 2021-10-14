class Mqtt
  Thread.new do
    require 'mqtt'
      
    client = MQTT::Client.connect(
      #host: abcedefghijkl.iot.us-west-2.amazonaws.com, # Your AWS IoT host
      host: 'localhost',
      port: 1883
      # port: 8883,
      # ssl: true,
      # cert_file: “the path to 'Certificate file' ”,
      # key_file: “the path to 'Private key file' ”,
      # ca_file: “the path to 'Root CA certificate file’ ”
    )
  
    client.subscribe( 'topic1' )
  
    client.get do |topic, message|
      PrometheusMetricSenderService.new(topic, message.to_f, 'iot').execute
    end
  end
end
