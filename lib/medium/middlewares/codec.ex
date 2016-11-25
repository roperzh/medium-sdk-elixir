defmodule Medium.Middlewares.Codec do
  @moduledoc """
  This module acts as a `Tesla` middleware in order to process
  the responses coming from the Medium API.
  """

  def call(env, next, _opts) do
    @doc """
    This method is caled when this module is plugged as a middleware, and
    is in charge of processing the request by:

    - Handling error responses via `descompose_keys/1`
    - Converting all CamelCase keys to snake_case via `snake_keys/1`
    - Converting all string keys to atom keys via `string_to_atom_keys/1`
    """

    env
    |> Tesla.run(next)
    |> descompose_keys
    |> snake_keys
    |> string_to_atom_keys
  end

  @spec descompose_keys(Map.t) :: Map
  def descompose_keys(response) do
    @doc """
    Extract from the response Map the errors
    or the response data.
    """

    case Map.get(response, :body) do
      %{"data" => data} -> data
      errors -> errors
    end
  end

  @spec snake_keys(Map.t) :: Map
  def snake_keys(data) when is_map(data) do
    @doc """
    Converts to snake_case all the keys of a given map

    ## Examples

      string_to_atom_keys(%{"keyOne" => 1})
      //=> %{"key_one" => 1}
    """

    Enum.reduce data, %{}, fn {k, v}, acc ->
      Map.put(acc, Macro.underscore(k), v)
    end
  end

  @spec snake_keys(List.t) :: Map
  def snake_keys(data) when is_list(data) do
    @doc """
    Converts to snake_case all the keys of all maps inside a list

    ## Examples

      string_to_atom_keys([%{"keyOne" => 1}, %{"keyTwo" => 2}])
      //=> [%{"key_one" => 1}, %{"key_two" => 2}]
    """

    Enum.map data, &snake_keys/1
  end

  @spec string_to_atom_keys(Map.t) :: Map
  def string_to_atom_keys(map) when is_map(map) do
    @doc """
    Converts all string keys in a map to atom keys

    ## Examples

      string_to_atom_keys(%{"one" => 1})
      //=> %{one: 1}
    """

    for {key, val} <- map,
      into: %{},
      do: {String.to_atom(key), string_to_atom_keys(val)}
  end

  @spec string_to_atom_keys(List.t) :: List
  def string_to_atom_keys(list) when is_list(list) do
    @doc """
    Converts all string keys in list of maps to atom keys

    ## Examples

      string_to_atom_keys(%{"one" => 1})
      //=> %{one: 1}
    """

    Enum.map(list, &string_to_atom_keys/1)
  end

  def string_to_atom_keys(val), do: val
end
