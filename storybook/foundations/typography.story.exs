defmodule Storybook.Foundations.Typography do
  use PhoenixStorybook.Story, :page

  def description, do: "ZAQ type scale — font families, heading levels, body text, and code."

  def render(assigns) do
    ~H"""
    <div style="font-family: var(--zaq-font-primary, sans-serif); padding: 2rem; display: flex; flex-direction: column; gap: 3rem; max-width: 760px;">

      <!-- Font families -->
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">Font Families</h2>
        <div style="display: flex; flex-direction: column; gap: 1.25rem;">
          <div style="display: flex; flex-direction: column; gap: 0.25rem;">
            <span style="font-family: var(--zaq-font-primary); font-size: 1.5rem; font-weight: 400;">ZAQ Sans — Primary UI</span>
            <span style="font-family: ui-monospace, monospace; font-size: 0.65rem; opacity: 0.4;">--zaq-font-primary · Roboto Variable</span>
          </div>
          <div style="display: flex; flex-direction: column; gap: 0.25rem;">
            <span style="font-family: var(--zaq-font-ui, sans-serif); font-size: 1.5rem; font-weight: 400;">Outfit — UI Accent</span>
            <span style="font-family: ui-monospace, monospace; font-size: 0.65rem; opacity: 0.4;">--zaq-font-ui · Outfit</span>
          </div>
          <div style="display: flex; flex-direction: column; gap: 0.25rem;">
            <span style="font-family: ui-monospace, monospace; font-size: 1.25rem;">Monospace — Code &amp; data</span>
            <span style="font-family: ui-monospace, monospace; font-size: 0.65rem; opacity: 0.4;">ui-monospace</span>
          </div>
        </div>
      </section>

      <!-- Heading scale -->
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">Heading Scale</h2>
        <div style="display: flex; flex-direction: column; gap: 1rem;">
          <.type_row label="H1 · 2rem / 700"  style="font-size: 2rem; font-weight: 700; line-height: 1.2;" sample="Page title" />
          <.type_row label="H2 · 1.5rem / 600" style="font-size: 1.5rem; font-weight: 600; line-height: 1.3;" sample="Section heading" />
          <.type_row label="H3 · 1.25rem / 600" style="font-size: 1.25rem; font-weight: 600; line-height: 1.35;" sample="Subsection" />
          <.type_row label="H4 · 1rem / 600"    style="font-size: 1rem; font-weight: 600; line-height: 1.4;" sample="Card title" />
          <.type_row label="H5 · 0.875rem / 600" style="font-size: 0.875rem; font-weight: 600; line-height: 1.4;" sample="Label heading" />
        </div>
      </section>

      <!-- Body scale -->
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">Body Scale</h2>
        <div style="display: flex; flex-direction: column; gap: 1rem;">
          <.type_row label="body-lg · 1rem / 400"     style="font-size: 1rem; font-weight: 400; line-height: 1.6;"   sample="The quick brown fox jumps over the lazy dog." />
          <.type_row label="body · 0.875rem / 400"    style="font-size: 0.875rem; font-weight: 400; line-height: 1.6;" sample="The quick brown fox jumps over the lazy dog." />
          <.type_row label="body-sm · 0.8125rem / 400" style="font-size: 0.8125rem; font-weight: 400; line-height: 1.55;" sample="The quick brown fox jumps over the lazy dog." />
          <.type_row label="caption · 0.75rem / 400"  style="font-size: 0.75rem; font-weight: 400; line-height: 1.5; opacity: 0.6;" sample="Metadata, helper text, timestamps." />
        </div>
      </section>

      <!-- Code -->
      <section>
        <h2 style="font-size: 0.7rem; font-weight: 600; letter-spacing: 0.1em; text-transform: uppercase; opacity: 0.45; margin-bottom: 1.5rem;">Code &amp; Monospace</h2>
        <div style="display: flex; flex-direction: column; gap: 0.75rem;">
          <code style="font-family: ui-monospace, monospace; font-size: 0.82em; background: rgba(0,0,0,0.04); padding: 0.15em 0.4em; border-radius: 4px; display: inline-block;">inline code snippet</code>
          <pre style="background: #1a1a1a; color: #e5e5e5; padding: 1.25em 1.5em; border-radius: 12px; overflow-x: auto; font-family: ui-monospace, monospace; font-size: 0.85em; line-height: 1.6;">def hello(name), do: "Hello, " &lt;&gt; name &lt;&gt; "!"</pre>
        </div>
      </section>

    </div>
    """
  end

  defp type_row(assigns) do
    ~H"""
    <div style="display: flex; flex-direction: column; gap: 0.2rem; padding-bottom: 1rem; border-bottom: 1px solid rgba(0,0,0,0.05);">
      <span style={"font-family: var(--zaq-font-primary, sans-serif); color: var(--zaq-color-ink, #2c3a50); #{@style}"}><%= @sample %></span>
      <span style="font-family: ui-monospace, monospace; font-size: 0.65rem; opacity: 0.35;"><%= @label %></span>
    </div>
    """
  end
end
