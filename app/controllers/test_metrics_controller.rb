class TestMetricsController < ApplicationController
  def create
    PrometheusMetricSenderService.new(permitted_params.merge(origin: 'api')).execute

    render json: { status: "ok" }
  end

  private

  def permitted_params
    params.permit(:name, :value)
  end
end
