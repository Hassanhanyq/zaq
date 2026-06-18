defmodule Storybook.Chat.MessageInfoPopin do
  use PhoenixStorybook.Story, :component

  def function, do: &ZaqWeb.Components.ChatMessage.message_info_popin/1

  def description,
    do:
      "BO Chat — message metadata modal (agent, model, measurements, trace timeline). " <>
        "Opened from the assistant row info control in `ChatLive` / `ConversationDetailLive`. " <>
        "Styling is legacy (design-migrate backlog)."

  @sample_message_info %{
    agent: %{"name" => "Answering Agent"},
    model: "openai:gpt-4o-mini",
    measurements: %{"latency_ms" => 42, "tokens_out" => 128},
    traces: [
      %{
        "id" => "trace-1",
        "type" => "tool_call",
        "name" => "search_code",
        "started_at" => "2026-05-02T10:00:00Z",
        "duration_ms" => 42
      },
      %{
        "id" => "trace-2",
        "type" => "llm",
        "name" => "respond",
        "started_at" => "2026-05-02T10:00:01Z",
        "duration_ms" => 120
      }
    ]
  }

  @base_attrs %{
    message_id: "story-msg-info-1",
    close_event: "close_message_info_modal",
    toggle_event: "toggle_trace_details"
  }

  def variations do
    [
      %Variation{
        id: :hidden,
        description: "Closed (not mounted in DOM)",
        attributes:
          Map.merge(@base_attrs, %{
            visible: false,
            message_info: @sample_message_info,
            expanded_ids: MapSet.new()
          })
      },
      %Variation{
        id: :open,
        description: "Open — agent, model, measurements, collapsed traces",
        attributes:
          Map.merge(@base_attrs, %{
            visible: true,
            message_info: @sample_message_info,
            expanded_ids: MapSet.new()
          })
      },
      %Variation{
        id: :trace_expanded,
        description: "Open — first trace expanded (full JSON)",
        attributes:
          Map.merge(@base_attrs, %{
            visible: true,
            message_info: @sample_message_info,
            expanded_ids: MapSet.new(["trace-1"])
          })
      },
      %Variation{
        id: :empty_metadata,
        description: "Open — minimal / empty message_info",
        attributes:
          Map.merge(@base_attrs, %{
            visible: true,
            message_info: %{},
            expanded_ids: MapSet.new()
          })
      }
    ]
  end
end
