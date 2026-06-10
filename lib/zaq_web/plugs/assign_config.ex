defmodule ZaqWeb.Plugs.AssignConfig do
  @moduledoc """
  Assigns a connection value from application configuration.

  The default fallback is provided by the plug caller as part of the config tuple,
  keeping each injected assign explicit at the router boundary.
  """
  @behaviour Plug

  import Plug.Conn

  @impl Plug
  def init(opts) do
    assign = Keyword.fetch!(opts, :assign)
    {app, key, default} = Keyword.fetch!(opts, :config)

    %{assign: assign, app: app, key: key, default: default}
  end

  @impl Plug
  def call(conn, %{assign: assign, app: app, key: key, default: default}) do
    assign(conn, assign, Application.get_env(app, key, default))
  end
end
