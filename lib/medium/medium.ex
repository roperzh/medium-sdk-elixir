defmodule Medium do
  @moduledoc ~s"""
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
  [MIT License](https://github.com/roperzh/medium-sdk-elixir/blob/master/LICENSE).
  """

  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.medium.com/v1"
  plug Medium.Middlewares.Codec

  adapter Tesla.Adapter.Hackney

  def client(token) do
    Tesla.build_client [
      {Tesla.Middleware.Headers, %{"Authorization" => "Bearer #{token}" }}
    ]
  end

  def me(client) do
    get client, "/me"
  end

  def publications(client, user_id) do
    get client, "/users/#{user_id}/publications"
  end
end
