defmodule Zaq.Contracts.Record do
  @moduledoc "Canonical domain-agnostic record payload."

  @derive {
    Jason.Encoder,
    only: [
      :id,
      :kind,
      :content,
      :name,
      :parent_id,
      :mime_type,
      :path,
      :url,
      :size,
      :description,
      :icon,
      :created_at,
      :modified_at,
      :change_type,
      :lifecycle_state,
      :deleted_at,
      :permissions,
      :parent_ids,
      :owners,
      :attributes
    ]
  }

  @enforce_keys [:id, :kind]
  defstruct [
    :id,
    :kind,
    :content,
    :name,
    :parent_id,
    :mime_type,
    :path,
    :url,
    :size,
    :description,
    :icon,
    :created_at,
    :modified_at,
    :change_type,
    :lifecycle_state,
    :deleted_at,
    :permissions,
    parent_ids: [],
    owners: [],
    attributes: %{},
    raw: %{}
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          kind: :file | :folder | :permission | :spreadsheet | atom(),
          content: String.t() | [term()] | map() | nil,
          name: String.t() | nil,
          parent_id: String.t() | nil,
          parent_ids: [String.t()],
          mime_type: String.t() | nil,
          path: String.t() | nil,
          url: String.t() | nil,
          size: integer() | nil,
          description: String.t() | nil,
          owners: [map()],
          icon: map() | String.t() | nil,
          created_at: DateTime.t() | nil,
          modified_at: DateTime.t() | nil,
          change_type: :created | :updated | :deleted | nil,
          lifecycle_state: :active | :deleted | nil,
          deleted_at: DateTime.t() | nil,
          permissions: nil | [t()],
          attributes: map(),
          raw: map()
        }

  defmodule Materialized do
    @moduledoc "Materalized record struct"
    @enforce_keys [:id, :content, :name, :mime_type, :size]
    defstruct [:id, :content, :name, :mime_type, :size]

    @type t :: %__MODULE__{
            id: String.t(),
            content: binary(),
            name: String.t(),
            mime_type: String.t(),
            size: non_neg_integer()
          }
  end

  @doc """
  Builds a `%Materialized{}` struct from a `%Record{}`.
  When `content` is already populated it wraps it directly.
  When `path` is present it reads the file.
  """
  @spec build_materialized(t()) :: Materialized.t()
  def build_materialized(%__MODULE__{content: content} = record) when is_binary(content) do
    %Materialized{
      id: record.id,
      content: content,
      name: record.name || Path.basename(record.path || ""),
      mime_type: record.mime_type || "application/octet-stream",
      size: record.size || byte_size(content)
    }
  end

  def build_materialized(%__MODULE__{path: path} = record) when is_binary(path) do
    content = File.read!(path)
    build_materialized(%{record | content: content, size: byte_size(content)})
  end
end
