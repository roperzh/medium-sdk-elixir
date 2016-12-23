defmodule Medium.Helpers.Keys do
  @moduledoc """
  Helper functions to deal with map keys
  """
  use Medium.Helpers.KeysMacros

  @doc ~S"""
  Converts a map with atom keys into a map with string keys.

  ## Examples

      iex> Medium.Helpers.Keys.to_str %{one: 1, two: 2}
      %{"one" => 1, "two" => 2}
  """
  key_function :to_str, &Atom.to_string/1

  @doc ~S"""
  Converts a map with string keys into a map with atom keys.

  ## Examples

      iex> Medium.Helpers.Keys.to_atom %{"one" => 1, "two" => 2}
      %{one: 1, two: 2}
  """
  key_function :to_atom, &String.to_atom/1

  @doc ~S"""
  Converts a map with camelCase keys into snake_case keys.

  Please note that this function assumes that the keys of the map are
  binaries.

  ## Examples

      iex> Medium.Helpers.Keys.to_snake %{"numberOne" => 1, "numberTwo" => 2}
      %{"number_one" => 1, "number_two" => 2}
  """
  key_function :to_snake, &Macro.underscore/1
end
