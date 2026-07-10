defmodule ZaqWeb.Helpers.Timezone do
  @moduledoc """
  Timezone module for BO.
  """

  def shift(nil), do: nil

  def shift(%DateTime{} = dt) do
    case system_timezone() do
      nil -> dt
      gmt_string -> shift_by_gmt_offset(dt, gmt_string)
    end
  end

  def shift(%NaiveDateTime{} = ndt) do
    ndt |> DateTime.from_naive!("Etc/UTC") |> shift()
  end

  def offset_to_gmt_string(offset_str) do
    offset = String.to_integer(offset_str)
    hours = div(abs(offset), 60)
    mins = rem(abs(offset), 60)
    sign = if offset <= 0, do: "+", else: "-"

    "GMT#{sign}#{String.pad_leading(to_string(hours), 2, "0")}:#{String.pad_leading(to_string(mins), 2, "0")}"
  end

  defp shift_by_gmt_offset(%DateTime{} = dt, "GMT+" <> rest) do
    [h, m] = String.split(rest, ":")
    offset_sec = (String.to_integer(h) * 60 + String.to_integer(m)) * 60
    dt |> DateTime.to_naive() |> NaiveDateTime.add(offset_sec, :second)
  end

  defp shift_by_gmt_offset(%DateTime{} = dt, "GMT-" <> rest) do
    [h, m] = String.split(rest, ":")
    offset_sec = -(String.to_integer(h) * 60 + String.to_integer(m)) * 60
    dt |> DateTime.to_naive() |> NaiveDateTime.add(offset_sec, :second)
  end

  defp system_timezone do
    Process.get(:zaq_system_timezone) || load_system_timezone()
  end

  defp load_system_timezone do
    fun = Application.get_env(:zaq, :system_timezone_fun, &Zaq.System.get_system_timezone/0)
    tz = fun.()
    Process.put(:zaq_system_timezone, tz)
    tz
  end
end
