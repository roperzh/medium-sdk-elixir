defmodule Medium.MeTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :me

  test "#me/1 receives a client and returns user information", helpers do
    Bypass.expect helpers.bypass, fn conn ->
      assert "/me" == conn.request_path
      assert "GET" == conn.method
      resp conn, 200, %{id: 123, imageUrl: "some"}
    end

    user_info = Medium.me(helpers.client)
    assert user_info.id == 123
    assert user_info.image_url == "some"
  end
end
