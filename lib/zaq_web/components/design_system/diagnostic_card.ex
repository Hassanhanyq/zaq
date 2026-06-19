defmodule ZaqWeb.Components.DesignSystem.DiagnosticCard do
  @moduledoc """
  Service / connection card: label, optional connection status chip, rows in the default slot,
  and optional test action (`phx-click` event name handled by the parent LiveView).
  """

  use Phoenix.Component

  import ZaqWeb.Components.DesignSystem.StatusBadge, only: [status_badge: 1]

  attr :label, :string, required: true
  attr :status, :any, default: nil
  attr :event, :string, default: nil
  attr :button_label, :string, default: "Test Connection"
  slot :inner_block, required: true
  slot :footer_extra

  def diagnostic_card(assigns) do
    ~H"""
    <div
      class="zaq-card-default zaq-border-default flex flex-col"
      style="background-color: var(--zaq-surface-color-raised)"
    >
      <div class="flex items-center justify-between">
        <p
          class="zaq-text-caption uppercase tracking-wider"
          style="color: var(--zaq-text-color-body-tertiary)"
        >
          {@label}
        </p>
        <.status_badge :if={@status != nil} status={@status} />
      </div>
      <div class="space-y-2">
        {render_slot(@inner_block)}
      </div>
      <div :if={@event} class="mt-auto pt-3">
        <button
          phx-click={@event}
          disabled={@status == :loading}
          class="zaq-btn zaq-btn-tertiary zaq-btn-text_label-default w-full zaq-focus-visible"
        >
          {if @status == :loading, do: "Testing…", else: @button_label}
        </button>
        <p
          :if={is_tuple(@status) and elem(@status, 0) == :error}
          class="zaq-text-caption mt-2 break-all"
          style="color: var(--zaq-text-color-body-danger)"
        >
          {elem(@status, 1)}
        </p>
        {render_slot(@footer_extra)}
      </div>
    </div>
    """
  end
end
