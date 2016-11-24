defmodule Medium.Middlewares.CodecTest do
  use ExUnit.Case, async: true

  alias Medium.Middlewares.Codec

  @moduletag utils: :map_helper

  test "#string_to_atom_keys converts all string keys to atoms" do
    string_keys = %{"one" => 1, "two" => 2}
    atom_keys = Codec.string_to_atom_keys string_keys

    assert atom_keys.one == 1
    assert atom_keys.two == 2
  end

  test "#string_to_atom_keys works with nested Maps" do
    string_keys = %{"one" => 1, "two" => %{"three" => 3}}
    atom_keys = Codec.string_to_atom_keys string_keys

    assert atom_keys.one == 1
    assert atom_keys.two.three == 3
  end

  test "#string_to_atom_keys works with nested Lists" do
    string_keys = %{"one" => 1, "two" => [%{"three" => 3}]}
    atom_keys = Codec.string_to_atom_keys string_keys

    assert atom_keys.one == 1
    assert atom_keys.two == [%{three: 3}]
  end
end
