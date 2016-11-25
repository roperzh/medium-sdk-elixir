defmodule Medium.Cases.ApiCase do
  use ExUnit.CaseTemplate
  use Tesla

  using do
    quote do
      def resp(conn, code \\ 200, params \\ %{}, errored \\ false) do
        params = case errored do
          false -> %{data: params}
          true -> %{errors: params}
        end

        resp_data = Poison.encode!(params)

        conn
        |> Plug.Conn.resp(code, resp_data)
        |> Plug.Conn.put_resp_content_type("application/json")
      end

      def build_post do
        %{
          title: "Liverpool FC",
          content_format: "html",
          content: "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>",
          canonical_url: "http://jamietalbot.com/posts/liverpool-fc",
          tags: ["football", "sport", "Liverpool"],
          publish_status: "public"
        }
      end
    end
  end

  setup do
    bypass = Bypass.open
    client = Medium.client("random-token", "http://localhost:#{bypass.port}")

    {:ok, client: client, bypass: bypass}
  end
end
