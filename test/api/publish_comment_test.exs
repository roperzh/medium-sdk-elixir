defmodule Medium.PublishCommentTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :publish_comment

  test "#publish_comment/1", helpers do
    publication_id = 15
    post = %{
      title: "Liverpool FC",
      content_format: "html",
      content: "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>",
      canonical_url: "http://jamietalbot.com/posts/liverpool-fc",
      tags: ["football", "sport", "Liverpool"],
      publish_status: "public"
    }

    Bypass.expect helpers.bypass, fn conn ->
      assert "/publications/#{publication_id}/posts" == conn.request_path
      assert "POST" == conn.method
      resp conn, 200, %{}
    end

    helpers.client |> Medium.publish_comment(publication_id, post)
  end
end