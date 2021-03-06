defmodule Medium do
  @moduledoc """
  Medium is an Elixir library that provides an interface to interact
  with the Medium API.

  ## Installation
  1. Add Medium to your list of dependencies in `mix.exs`:
          def deps do
            [{:medium_client, "~> #{Medium.Mixfile.project[:version]}"}]
          end
  2. Ensure Medium is started before your application:
          def application do
            [applications: [:medium_client]]
          end
  ## Authorship and License
  Medium is copyright 2016 Roberto Dip (http://roperzh.com)
  Medium is released under the
  [MIT License]
  (https://github.com/roperzh/medium-sdk-elixir/blob/master/LICENSE).
  """

  use Tesla

  alias Medium.Helpers.Query

  plug Medium.Middlewares.Codec
  plug Tesla.Middleware.JSON

  adapter Tesla.Adapter.Hackney

  @base_url "https://api.medium.com/v1"
  @auth_url "https://medium.com/m/oauth/authorize?"

  @doc """
  Generate an authorization URL

  Parameters for the url must be provided as a map, with the following
  required keys:

  - `client_id`, String
  - `scope`, List of String elements
  - `state`, String
  - `response_type`, String
  - `redirect_uri`, String

  For more details, please check the official [documentation]
  (https://github.com/Medium/medium-api-docs#21-browser-based-authentication)

  """
  def authorize_url(query) do
    @auth_url <> Query.encode(query)
  end

  @doc """
  Request for a token

  Parameters for the url must be provided as a map, with the following
  required keys:

  - `code`, String generated with the url provided via `authorize_url/1`
  - `client_id`, String
  - `client_secret`, String
  - `grant_type`, String
  - `redirect_uri`, String

  For more details, please check the official [documentation]
  (https://github.com/Medium/medium-api-docs#21-browser-based-authentication)
  """
  def get_token(query, url \\ @base_url) do
    post url <> "/tokens", query
  end

  @doc """
  Generate a client which will use a defined `token` for future requests

  Optionally the client accepts a custom base url to be used for all request
  this can be useful for future api versions and testing.

  ## Examples

      client = Medium.client("my-access-token")
      test_client = Medium.client("my-acces-token", "http://localhost")
  """
  def client(token, url \\ @base_url) do
    Tesla.build_client [
      {Tesla.Middleware.BaseUrl, url},
      {Tesla.Middleware.Headers, %{"Authorization" => "Bearer #{token}"}}
    ]
  end

  @doc """
  Returns details of the user who has granted permission to the application.

  _Please check the official
  [documentation](https://github.com/Medium/medium-api-docs#31-users)_

  ## Examples

      user_info = Medium.client("token") |> Medium.me
      user_info.username //=> "roperzh"
      user_info.image_url //=> "https://images.medium.com/0*fkfQT7TlUGGyI.png"
  """
  def me(client) do
    get client, "/me"
  end

  @doc """
  Returns a full list of publications that the user is related to in some way.

  _Please check the official [documentation]
  (https://github.com/Medium/medium-api-docs#listing-the-users-publications)_

  ## Examples

      publications = Medium.client("token") |> Medium.publications("user_id")
  """
  def publications(client, user_id) do
    get client, "/users/#{user_id}/publications"
  end

  @doc """
  Returns a list of contributors for a given publication.

  _Please check the official [documentation]
  (https://github.com/Medium/medium-api-docs#listing-the-users-publications)_


  ## Examples

      contributors =
        token
        |> Medium.client
        |> Medium.publications("publication_id")
  """
  def contributors(client, publication_id) do
    get client, "/publications/#{publication_id}/contributors"
  end

  @doc """
  Creates a post on the authenticated user’s profile.

  _Please check the official
  [documentation](https://github.com/Medium/medium-api-docs#creating-a-post)_

  ## Examples

      resp = Medium.client("token") |> Medium.publish("user_id", publication)
  """
  def publish(client, author_id, publication) do
    post client, "/users/#{author_id}/posts", publication
  end

  @doc """
  This API allows creating a post and associating it with a
  publication on Medium.

  _Please check the official [documentation]
  (http://github.com/Medium/medium-api-docs#creating-a-post-under-a-publication)_

  ## Examples

      resp =
        token
        |> Medium.client
        |> Medium.publish_comment("publication_id", publication_data)
  """
  def publish_comment(client, publication_id, publication) do
    post client, "/publications/#{publication_id}/posts", publication
  end
end
