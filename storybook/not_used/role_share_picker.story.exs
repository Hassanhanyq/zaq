defmodule Storybook.NotUsed.RoleSharePicker do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.Components.RoleSharePicker.role_share_picker/1

  def description,
    do:
      "Multi-select role assignment. When no roles are selected, the resource is private (accessible only to the ingesting user's role)."

  def variations do
    [
      %VariationGroup{
        id: :selection_states,
        description: "Selection states",
        variations: [
          %Variation{
            id: :none_selected,
            description: "No roles selected — resource is private",
            attributes: %{
              roles: [
                %{id: 1, name: "Admin"},
                %{id: 2, name: "Support"},
                %{id: 3, name: "Viewer"}
              ],
              selected_role_ids: []
            }
          },
          %Variation{
            id: :one_selected,
            description: "One role selected",
            attributes: %{
              roles: [
                %{id: 1, name: "Admin"},
                %{id: 2, name: "Support"},
                %{id: 3, name: "Viewer"}
              ],
              selected_role_ids: [2]
            }
          },
          %Variation{
            id: :multiple_selected,
            description: "Multiple roles selected",
            attributes: %{
              roles: [
                %{id: 1, name: "Admin"},
                %{id: 2, name: "Support"},
                %{id: 3, name: "Viewer"}
              ],
              selected_role_ids: [1, 2, 3]
            }
          }
        ]
      }
    ]
  end
end
