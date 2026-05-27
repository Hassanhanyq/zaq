defmodule Storybook.Foundations.Spacing do
  use PhoenixStorybook.Story, :page

  def description, do: "ZAQ spacing scale — base-8 grid from 0 to 80px."

  def render(assigns) do
    ~H"""
    <div style="font-family: var(--zaq-font-primary, sans-serif); padding: 2rem; display: flex; flex-direction: column; gap: 0.5rem; max-width: 600px;">
      <p style="font-size: 0.75rem; opacity: 0.45; margin-bottom: 1.5rem;">Base-8 grid. Each bar represents the token's raw pixel value.</p>

      <.scale_row token="--scale-0"    label="0"    px="0px"   />
      <.scale_row token="--scale-2"    label="2"    px="2px"   />
      <.scale_row token="--scale-4"    label="4"    px="4px"   />
      <.scale_row token="--scale-8"    label="8"    px="8px"   />
      <.scale_row token="--scale-12"   label="12"   px="12px"  note="small text only" />
      <.scale_row token="--scale-16"   label="16"   px="16px"  />
      <.scale_row token="--scale-24"   label="24"   px="24px"  />
      <.scale_row token="--scale-32"   label="32"   px="32px"  />
      <.scale_row token="--scale-40"   label="40"   px="40px"  />
      <.scale_row token="--scale-42"   label="48"   px="48px"  note="token: scale-42" />
      <.scale_row token="--scale-56"   label="56"   px="56px"  />
      <.scale_row token="--scale-64"   label="64"   px="64px"  />
      <.scale_row token="--scale-72"   label="72"   px="72px"  />
      <.scale_row token="--scale-80"   label="80"   px="80px"  />
    </div>
    """
  end

  defp scale_row(assigns) do
    assigns = Map.put_new(assigns, :note, nil)
    ~H"""
    <div style="display: grid; grid-template-columns: 48px 1fr 72px; align-items: center; gap: 1rem; padding: 0.3rem 0;">
      <span style="font-family: ui-monospace, monospace; font-size: 0.7rem; opacity: 0.5; text-align: right;"><%= @px %></span>
      <div style={"height: 12px; border-radius: 3px; background: var(--zaq-color-accent, #03b6d4); width: var(#{@token}, #{@px}); min-width: 2px;"}></div>
      <span style="font-family: ui-monospace, monospace; font-size: 0.65rem; opacity: 0.35; white-space: nowrap;"><%= @note %></span>
    </div>
    """
  end
end
