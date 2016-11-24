defmodule Medium.PublishTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :publish

  test "#publish/3", helpers do
    user_id = 15
    post = build_post

    Bypass.expect helpers.bypass, fn conn ->
      assert "/users/#{user_id}/posts" == conn.request_path
      assert "POST" == conn.method
      resp conn, 200, []
    end

    helpers.client |> Medium.publish(user_id, post)
  end
end