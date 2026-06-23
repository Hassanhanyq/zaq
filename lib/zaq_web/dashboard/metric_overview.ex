defmodule ZaqWeb.Dashboard.MetricOverview do
  @moduledoc """
  BO main dashboard — KPI metric cards grid and deep links to metric sub-pages.
  """

  use Phoenix.Component

  import ZaqWeb.Components.DesignSystem.MetricCard, only: [metric_card: 1]

  attr :metric_cards, :list, required: true

  def metric_overview(assigns) do
    ~H"""
    <div class="mb-8 grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-3">
      <.metric_card
        :for={metric <- @metric_cards}
        id={metric.id <> "-card"}
        card={metric}
        primary_link={
          %{
            id: metric.id,
            destination: metric.runtime.href || "/bo/dashboard"
          }
        }
        secondary_link={secondary_link_for(metric.id)}
      />
    </div>
    """
  end

  defp secondary_link_for("dashboard-metric-documents-ingested") do
    %{
      id: "dashboard-knowledge-base-metrics-link",
      destination: "/bo/dashboard/knowledge-base-metrics",
      label: "View Knowledge base metrics",
      tone: :accent,
      size: :sm,
      icon: "hero-arrow-right",
      icon_position: :right
    }
  end

  defp secondary_link_for("dashboard-metric-llm-api-calls") do
    %{
      id: "dashboard-llm-performance-link",
      destination: "/bo/dashboard/llm-performance",
      label: "View LLM performance",
      tone: :accent,
      size: :sm,
      icon: "hero-arrow-right",
      icon_position: :right
    }
  end

  defp secondary_link_for("dashboard-metric-qa-response-time") do
    %{
      id: "dashboard-conversations-metrics-link",
      destination: "/bo/dashboard/conversations-metrics",
      label: "View Conversations metrics",
      tone: :accent,
      size: :sm,
      icon: "hero-arrow-right",
      icon_position: :right
    }
  end

  defp secondary_link_for(_), do: nil
end
