defmodule ZaqWeb.Components.DesignSystem.SimplePagination do
  @moduledoc """
  Range label with optional Prev/Next controls for BO list panels.

  Used on `/bo/people` and similar paginated master lists. Prev/Next buttons render
  only when another page exists in that direction.

  Styles: `assets/css/table.css` (`.zaq-simple-pagination` shell).
  """

  use Phoenix.Component

  import ZaqWeb.Components.DesignSystem.Button

  attr :page, :integer, required: true
  attr :per_page, :integer, required: true
  attr :total_count, :integer, required: true
  attr :change_event, :string, default: "change_page"

  def simple_pagination(assigns) do
    ~H"""
    <div :if={@total_count > 0} class="zaq-simple-pagination">
      <span
        class="zaq-text-caption"
        style="color: var(--zaq-text-color-body-tertiary)"
        data-testid="simple-pagination-range"
      >
        {@page * @per_page - @per_page + 1}–{min(@page * @per_page, @total_count)} of {@total_count}
      </span>
      <div class="zaq-layout-inline-compact">
        <.button
          :if={@page > 1}
          variant={:ghost}
          phx-click={@change_event}
          phx-value-page={@page - 1}
        >
          ← Prev
        </.button>
        <.button
          :if={@page * @per_page < @total_count}
          variant={:ghost}
          phx-click={@change_event}
          phx-value-page={@page + 1}
        >
          Next →
        </.button>
      </div>
    </div>
    """
  end
end
