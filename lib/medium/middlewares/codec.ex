defmodule Medium.Middlewares.Codec do
  @moduledoc """
  Acts as a `Tesla` middleware in order to process
  the responses coming from the Medium API.
  """

  alias Medium.Helpers.Keys

  @doc """
  This method is caled when this module is plugged as a middleware, and
  is in charge of processing the request by:

  - Handling error responses via `descompose_keys/1`
  - Converting all CamelCase keys to snake_case via `snake_keys/1`
  - Converting all string keys to atom keys via `string_to_atom_keys/1`
  """

  def call(env, next, _opts) do
    env
    |> Tesla.run(next)
    |> descompose_keys
    |> Keys.to_snake
    |> Keys.to_atom
  end

  @doc """
  Extract from the response Map the errors.
  or the response data.
  """
  @spec descompose_keys(Map.t) :: Map
  def descompose_keys(response) do
    case Map.get(response, :body) do
      %{"data" => data} -> data
      errors -> errors
    end
  end
end
