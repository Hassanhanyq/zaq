defmodule ZaqWeb.SearchableSelectTest do
  use ZaqWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias ZaqWeb.Components.SearchableSelect

  test "renders inline label and wraps control by default" do
    html =
      render_component(&SearchableSelect.searchable_select/1,
        id: "team-select",
        name: "team_id",
        label: "Team",
        options: [{"Engineering", 1}],
        value: 1
      )

    assert html =~ "zaq-field-row-inline"
    assert html =~ ~s(for="team-select-trigger")
    assert html =~ "zaq-field-label-uppercase zaq-text-caption"
    assert html =~ "Team"
    assert html =~ "zaq-field-row-inline-control"
    assert html =~ ~s(id="team-select")
    assert html =~ ~s(name="team_id")
    assert html =~ "zaq-text-body-sm zaq-dropdown-menu-item"
    assert html =~ "Engineering"
  end

  test "compact mode applies body-sm typography to trigger label" do
    html =
      render_component(&SearchableSelect.searchable_select/1,
        id: "role-select",
        name: "role",
        compact: true,
        searchable: false,
        options: [{"Admin", "admin"}],
        value: "admin"
      )

    assert html =~ "zaq-control-combobox-trigger--compact"
    assert html =~ ~s(data-select-label class="zaq-text-body-sm truncate min-w-0")
    assert html =~ "zaq-text-body-sm zaq-dropdown-menu-item"
  end

  test "does not render label wrapper for non-binary label" do
    html =
      render_component(&SearchableSelect.searchable_select/1,
        id: "team-select",
        name: "team_id",
        label: :team,
        options: [{"Engineering", 1}],
        value: 1
      )

    refute html =~ "zaq-field-row-inline"
    refute html =~ "zaq-field-row-block"
    refute html =~ "zaq-field-label-uppercase"
    assert html =~ ~s(id="team-select")
    assert html =~ ~s(name="team_id")
    assert html =~ "Engineering"
  end
end
