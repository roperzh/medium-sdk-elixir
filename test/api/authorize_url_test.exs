defmodule Medium.AuthorizeUrlTest do
  use ExUnit.Case, async: true

  test "appends all the passed parameters as a query string" do
    expected_url = "https://medium.com/m/oauth/authorize?"
      <> "redirect_uri=http%3A%2F%2Flocalhost"
      <> "&satate=random+text"
      <> "&scope=basicProfile%2CuploadImage"

    params = %{
      redirect_uri: "http://localhost",
      scope: ["basicProfile", "uploadImage"],
      satate: "random text"
    }

     assert Medium.authorize_url(params) == expected_url
  end
end
