class PrometheusMetricSenderService
  include Prometheus::General

  attr_reader :name, :value, :origin

  def initialize(name, value, origin)
    @name = name
    @value = value
    @origin = origin
  end

  def execute
    if !metric_created?(name)
      create_metric(name)
    end

    if origin != 'iot'
      export_to_test_gauge(value, origin, name)
    else
      export_to_iot_gauge(value, origin, name)
    end
  end

  private

  def metric_created?(metric_name)
    Metric.find_by(name: metric_name)
  end

  def create_metric(metric_name)
    Metric.create!(name: metric_name)
  end

  def export_to_test_gauge(current_value, current_origin, current_name)
    TEST_GAUGE
      .set(current_value, labels: { origin: current_origin.to_sym, name: current_name.to_sym })
  end

  def export_to_iot_gauge(current_value, current_origin, current_name)
    IOT_GAUGE
      .set(current_value, labels: { origin: current_origin.to_sym, name: current_name.to_sym })
  end
end
