defmodule Medium.ClientTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :client

  test "#client/1 returns a valid Tesla client" do
    client = Medium.client("random-token")

    assert is_function client
  end

  test "#client/1 uses the provided token for future requests", helpers do
    token = "awesome-token"
    client = Medium.client(token, "http://localhost:#{helpers.bypass.port}")

    Bypass.expect helpers.bypass, fn conn ->
      [auth | _headers] = conn.req_headers

      assert auth == {"authorization", "Bearer #{token}"}

      resp conn, 200, []
    end

    client |> Medium.me
  end
end