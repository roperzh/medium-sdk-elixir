defmodule Medium.Utils.MapHelper do
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
