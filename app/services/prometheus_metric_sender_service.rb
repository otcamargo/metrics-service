class PrometheusMetricSenderService

  def initialize(params)
    @label = params[:label]
    @content = params[:content]
  end

  def execute
    gauge = Prometheus::Client::Gauge.new(:mqtt_broker, docstring: '...', labels: [:room])
    binding.pry
    prometheus_client.register(gauge) if gauge.get(labels: { room: @label }) == nil

    gauge.set(@content, labels: { room: @label })
  end

  private

  def prometheus_client
    Prometheus::Client.registry
  end
end
