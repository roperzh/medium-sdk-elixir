defmodule MediumClient do
  @moduledoc ~s"""
  MediumClient is an Elixir library that provides an interface to interact
  with the Medium API.

  ## Installation
  1. Add MediumClient to your list of dependencies in `mix.exs`:
          def deps do
            [{:medium_client, "~> #{MediumClient.Mixfile.project[:version]}"}]
          end
  2. Ensure MediumClient is started before your application:
          def application do
            [applications: [:medium_client]]
          end
  ## Authorship and License
  MediumClient is copyright 2016 Roberto Dip (http://roperzh.com)
  MediumClient is released under the
  [MIT License](https://github.com/roperzh/medium-sdk-elixir/blob/master/LICENSE).
  """
end
