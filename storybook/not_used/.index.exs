defmodule Storybook.NotUsed do
  @moduledoc """
  Stories for UI that is not currently mounted in BO LiveView templates.

  Components may still exist for future use or tests; this folder is navigation-only.
  """

  use PhoenixStorybook.Index

  def folder_name, do: "NOT USED"
  def folder_index, do: 12
end
