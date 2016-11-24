defmodule Medium.Cases.ApiCase do
  use ExUnit.CaseTemplate
  use Tesla

  using do
    quote do
      def resp(conn, code \\ 200, params \\ %{}) do
        resp_data = Poison.encode!(%{data: params})

        conn
          |> Plug.Conn.resp(code, resp_data)
          |> Plug.Conn.put_resp_content_type("application/json")
      end
    end
  end

  setup do
    bypass = Bypass.open

    client = Tesla.build_client([
      {Tesla.Middleware.Headers, %{"Authorization" => "Bearer random-token" }},
      {Tesla.Middleware.BaseUrl, "http://localhost:#{bypass.port}"}
    ])

    {:ok, client: client, bypass: bypass}
  end
end
