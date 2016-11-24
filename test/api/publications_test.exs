defmodule Medium.PublicationsTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :publications

  test "#publications/2 sends the correct params and returns data", helpers do
    user_id = 15

    Bypass.expect helpers.bypass, fn conn ->
      assert "/users/#{user_id}/publications" == conn.request_path
      assert "GET" == conn.method
      resp conn, 200, []
    end

    publications = Medium.publications(helpers.client, user_id)
    assert is_list(publications)
  end
end
