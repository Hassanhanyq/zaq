defmodule ZaqWeb.Plugs.AssignConfigTest do
  use ZaqWeb.ConnCase

  alias ZaqWeb.Plugs.AssignConfig

  @config_key :assign_config_test_enabled

  setup do
    previous = Application.get_env(:zaq, @config_key)

    on_exit(fn ->
      case previous do
        nil -> Application.delete_env(:zaq, @config_key)
        value -> Application.put_env(:zaq, @config_key, value)
      end
    end)

    opts = AssignConfig.init(assign: :feature_enabled, config: {:zaq, @config_key, false})

    %{opts: opts}
  end

  test "assigns the configured fallback when config is missing", %{conn: conn, opts: opts} do
    Application.delete_env(:zaq, @config_key)

    conn = AssignConfig.call(conn, opts)

    assert conn.assigns.feature_enabled == false
  end

  test "assigns the configured value when config is present", %{conn: conn, opts: opts} do
    Application.put_env(:zaq, @config_key, true)

    conn = AssignConfig.call(conn, opts)

    assert conn.assigns.feature_enabled == true
  end
end
