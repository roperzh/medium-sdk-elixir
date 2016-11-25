defmodule Medium.Middlewares.Codec do
  @moduledoc """
  This module acts as a `Tesla` middleware in order to process
  the responses coming from the Medium API.
  """

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
    |> snake_keys
    |> string_to_atom_keys
  end

  @doc """
  Extract from the response Map the errors
  or the response data.
  """

  @spec descompose_keys(Map.t) :: Map
  def descompose_keys(response) do
    case Map.get(response, :body) do
      %{"data" => data} -> data
      errors -> errors
    end
  end

  @doc """
  Converts to snake_case all the keys of a given map

  ## Examples

    string_to_atom_keys(%{"keyOne" => 1})
    //=> %{"key_one" => 1}
  """

  @spec snake_keys(Map.t) :: Map
  def snake_keys(data) when is_map(data) do
    Enum.reduce data, %{}, fn {k, v}, acc ->
      Map.put(acc, Macro.underscore(k), v)
    end
  end

  @doc """
  Converts to snake_case all the keys of all maps inside a list

  ## Examples

    string_to_atom_keys([%{"keyOne" => 1}, %{"keyTwo" => 2}])
    //=> [%{"key_one" => 1}, %{"key_two" => 2}]
  """

  @spec snake_keys(List.t) :: Map
  def snake_keys(data) when is_list(data) do
    Enum.map data, &snake_keys/1
  end

  @doc """
  Converts all string keys in a map to atom keys

  ## Examples

    string_to_atom_keys(%{"one" => 1})
    //=> %{one: 1}
  """

  @spec string_to_atom_keys(Map.t) :: Map
  def string_to_atom_keys(map) when is_map(map) do
    for {key, val} <- map,
      into: %{},
      do: {String.to_atom(key), string_to_atom_keys(val)}
  end

  @doc """
  Converts all string keys in list of maps to atom keys

  ## Examples

    string_to_atom_keys(%{"one" => 1})
    //=> %{one: 1}
  """

  @spec string_to_atom_keys(List.t) :: List
  def string_to_atom_keys(list) when is_list(list) do
    Enum.map(list, &string_to_atom_keys/1)
  end

  def string_to_atom_keys(val), do: val
end
