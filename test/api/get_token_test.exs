defmodule Medium.GetTokenTest do
  use Medium.Cases.ApiCase, async: true

  @moduletag api: :get_token

  test "&get_token/1 makes a POST request to the proper URL", helpers do
    Bypass.expect helpers.bypass, fn conn ->
      assert "/tokens" == conn.request_path
      assert "POST" == conn.method
      resp conn, 201, %{
        token_type: "Bearer",
        access_token: "access_token"
      }
    end

    token_response = Medium.get_token(%{
      code: "code returned from api",
      client_id: "3424",
      client_secret: "234324",
      grant_type: "authorization_code",
      redirect_uri: "http://localhost"
    }, "http://localhost:#{helpers.bypass.port}")

    assert token_response.token_type == "Bearer"
  end
end
