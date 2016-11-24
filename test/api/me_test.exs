defmodule Medium.MeTest do
  use ExUnit.Case, async: true
  use Tesla

  setup do
    bypass = Bypass.open

    client = Tesla.build_client([
      {Tesla.Middleware.Headers, %{"Authorization" => "Bearer random-token" }},
      {Tesla.Middleware.BaseUrl, "http://localhost:#{bypass.port}"}
    ])

    {:ok, client: client, bypass: bypass}
  end

  test "#me/1 receives a client and returns user information", helpers do
    Bypass.expect helpers.bypass, fn conn ->
      assert "/me" == conn.request_path
      assert "GET" == conn.method
      Plug.Conn.resp(conn, 200, Poison.encode!(%{id: 123}))
    end

    user_info = Medium.me(helpers.client)

    assert user_info.id == 123
  end
end
