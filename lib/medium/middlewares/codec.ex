defmodule Medium.Middlewares.Codec do

  def call(env, next, _opts) do
    env
    |> Tesla.run(next)
    |> Map.get(:body)
    |> get_in(["data"])
    |> snake_keys
    |> string_to_atom_keys
  end

  def snake_keys(data) when is_map(data) do
    Enum.reduce data, %{}, fn {k, v}, acc ->
      Map.put(acc, Macro.underscore(k), v)
    end
  end

  def snake_keys(data) when is_list(data) do
    Enum.map data, &snake_keys/1
  end

  @moduledoc """
    Utility functions to deal with Maps
  """

  @doc """
  Given a Map with keys of type String, returns a Map with
  keys of type Atom.

  This is specially useful to parse JSON responses.

  ## Examples

    string_to_atom_keys(%{"one" => 1}) //=> %{one: 1}
  """

  @spec string_to_atom_keys(Map.t) :: Map
  def string_to_atom_keys(map) when is_map(map) do
    for {key, val} <- map,
      into: %{},
      do: {String.to_atom(key), string_to_atom_keys(val)}
  end

  @spec string_to_atom_keys(List.t) :: List
  def string_to_atom_keys(list) when is_list(list) do
    list
    |> Enum.map(&string_to_atom_keys/1)
  end

  def string_to_atom_keys(val), do: val
end
