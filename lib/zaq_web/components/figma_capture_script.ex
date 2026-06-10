defmodule ZaqWeb.Components.FigmaCaptureScript do
  @moduledoc """
  Renders the optional Figma HTML-to-design capture script.
  """
  use Phoenix.Component

  attr :enabled, :boolean, required: true

  def figma_capture_script(assigns) do
    ~H"""
    <script
      :if={@enabled}
      src="https://mcp.figma.com/mcp/html-to-design/capture.js"
      async
    >
    </script>
    """
  end
end
