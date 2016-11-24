defmodule Medium.PublishCommentTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :publish_comment

  test "#publish_comment/3", helpers do
    publication_id = 15
    post = build_post

    Bypass.expect helpers.bypass, fn conn ->
      assert "/publications/#{publication_id}/posts" == conn.request_path
      assert "POST" == conn.method
      resp conn, 200, %{}
    end

    helpers.client |> Medium.publish_comment(publication_id, post)
  end
end