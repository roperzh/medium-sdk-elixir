defmodule Medium.Cases.ApiCase do
  use ExUnit.CaseTemplate
  use Tesla

  setup do
    bypass = Bypass.open

    client = Tesla.build_client([
      {Tesla.Middleware.Headers, %{"Authorization" => "Bearer random-token" }},
      {Tesla.Middleware.BaseUrl, "http://localhost:#{bypass.port}"}
    ])

    {:ok, client: client, bypass: bypass}
  end
end
