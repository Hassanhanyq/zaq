defmodule ZaqWeb.Live.BO.System.SystemConfig.GlobalEvents do
  @moduledoc """
  Helpers for global system config assign updates.
  """

  def apply_default_agent_saved(socket, current_default_agent_id) do
    Phoenix.Component.assign(socket, :global_default_agent_id, current_default_agent_id)
  end

  def apply_base_url_saved(socket, current_base_url) do
    Phoenix.Component.assign(socket, :global_base_url, current_base_url || "")
  end

  def apply_language_saved(socket, language) do
    Phoenix.Component.assign(socket, :global_language, language)
  end

  def apply_timezone_saved(socket, timezone) do
    Phoenix.Component.assign(socket, :global_timezone, timezone || "")
  end
end
