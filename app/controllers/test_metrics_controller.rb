class TestMetricsController < ApplicationController
  def create
    PrometheusMetricSenderService.new(params[:name], params[:value], 'api').execute

    render json: { status: "ok" }
  end

  private

  def permitted_params
    params.permit(:name, :value)
  end
end
