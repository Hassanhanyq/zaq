defmodule Zaq.Contracts.RecordTest do
  use ExUnit.Case, async: true

  alias Zaq.Contracts.Record
  alias Zaq.Contracts.Record.Materialized

  describe "build_materialized/1" do
    test "builds Materialized from Record with binary content" do
      record = %Record{
        id: "r1",
        kind: :file,
        content: "hello world",
        name: "greeting.txt",
        mime_type: "text/plain",
        size: 11
      }

      mat = Record.build_materialized(record)

      assert %Materialized{
               id: "r1",
               content: "hello world",
               name: "greeting.txt",
               mime_type: "text/plain",
               size: 11
             } = mat
    end

    test "falls back to Path.basename(path) when name is nil" do
      record = %Record{
        id: "r2",
        kind: :file,
        content: "data",
        path: "/some/dir/report.pdf",
        mime_type: "application/pdf"
      }

      mat = Record.build_materialized(record)

      assert mat.name == "report.pdf"
    end

    test "defaults mime_type to application/octet-stream when absent" do
      record = %Record{id: "r3", kind: :file, content: "binary data"}

      mat = Record.build_materialized(record)

      assert mat.mime_type == "application/octet-stream"
    end

    test "computes size from byte_size(content) when Record size is nil" do
      record = %Record{id: "r4", kind: :file, content: "12345"}

      mat = Record.build_materialized(record)

      assert mat.size == 5
    end
  end
end
