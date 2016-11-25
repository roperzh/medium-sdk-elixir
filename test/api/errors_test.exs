defmodule Medium.ErrorsTest do
  use Medium.Cases.ApiCase, async: true

  test "API handles error responses from the server", helpers do
    Bypass.expect helpers.bypass, fn conn ->
      assert "/me" == conn.request_path
      assert "GET" == conn.method
      resp conn, 401, [%{code: 3434, message: "some error"}], true
    end

    response = Medium.me(helpers.client)
    errors_list = response.errors
    error = List.first(errors_list)

    assert is_list(errors_list)
    assert Map.has_key?(error, :code)
    assert Map.has_key?(error, :message)
  end
end
