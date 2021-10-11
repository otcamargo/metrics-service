class TestMetricsController < ApplicationController
  def create
    # binding.pry
    PrometheusMetricSenderService.new(permitted_params).execute

    render json: { status: "ok" }
  end

  private

  def permitted_params
    params.permit(:label, :content)
  end
end
