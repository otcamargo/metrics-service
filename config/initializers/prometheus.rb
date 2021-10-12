module Prometheus
  module General

    # Create a default Prometheus registry for our metrics.
    prometheus = Prometheus::Client.registry

    # Create a simple gauge metric.
    IOT_GAUGE = Prometheus::Client::Gauge.new(:iot_measurements, docstring: 'A simple gauge that serves the purpose to collect data from the microcontrollers.', labels: [:origin, :name])
    TEST_GAUGE = Prometheus::Client::Gauge.new(:iot_measurements_tests_2, docstring: 'A simple gauge that serves the purpose to collect TEST data using an API.', labels: [:origin, :name])

    # Register GAUGE_EXAMPLE with the registry we previously created.
    prometheus.register(IOT_GAUGE)
    prometheus.register(TEST_GAUGE)

  end
end
