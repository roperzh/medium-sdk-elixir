defmodule Medium.PublicationsTest do
  use ExUnit.Case, async: true
  use Tesla

  @moduletag api: :publications

  setup do
    bypass = Bypass.open

    client = Tesla.build_client([
      {Tesla.Middleware.Headers, %{"Authorization" => "Bearer random-token" }},
      {Tesla.Middleware.BaseUrl, "http://localhost:#{bypass.port}"}
    ])

    {:ok, client: client, bypass: bypass}
  end

  test "#publications/2 sends the correct params and returns data", helpers do
    user_id = 15

    Bypass.expect helpers.bypass, fn conn ->
      assert "/users/#{user_id}/publications" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, Poison.encode!([]))
    end

    publications = Medium.publications(helpers.client, user_id)
    assert is_list(publications)
  end
end
