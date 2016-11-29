defmodule Medium.ContributorsTest do
  use Medium.Cases.ApiCase, async: true

  test "contributors/2 returns a list of contributors", helpers do
    publication_id = 15

    Bypass.expect helpers.bypass, fn conn ->
      assert "/publications/#{publication_id}/contributors" == conn.request_path
      assert "GET" == conn.method

      resp conn, 200, [%{publicationId: publication_id,
                          userId: "user_id",
                          role: "editor"}]
    end

    contributors = Medium.contributors(helpers.client, publication_id)
    contributor = List.first(contributors)

    assert is_list(contributors)
    assert is_map(contributor)
    assert Map.has_key?(contributor, :publication_id)
    assert Map.has_key?(contributor, :user_id)
  end
end
