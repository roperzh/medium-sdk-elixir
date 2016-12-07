defmodule Medium.KeysTest do
  use ExUnit.Case, async: true

  alias Medium.Helpers.Keys

  @moduletag helpers: :keys

  test "&to_atom/1 converts all string keys to atoms" do
    string_keys = %{"one" => 1, "two" => 2}
    atom_keys = Keys.to_atom string_keys

    assert atom_keys.one == 1
    assert atom_keys.two == 2
  end

  test "&to_atom/1 works with nested Maps" do
    string_keys = %{"one" => 1, "two" => %{"three" => 3}}
    atom_keys = Keys.to_atom string_keys

    assert atom_keys.one == 1
    assert atom_keys.two.three == 3
  end

  test "&to_atom/1 works with nested Lists" do
    string_keys = %{"one" => 1, "two" => [%{"three" => 3}]}
    atom_keys = Keys.to_atom string_keys

    assert atom_keys.one == 1
    assert atom_keys.two == [%{three: 3}]
  end

  test "&to_str/1 converts all string keys to strs" do
    atom_keys = %{one: 1, two: 2}
    str_keys = Keys.to_str atom_keys

    assert str_keys["one"] == 1
    assert str_keys["two"] == 2
  end

  test "&to_str/1 works with nested Maps" do
    atom_keys = %{one: 1, two: %{three: 3}}
    str_keys = Keys.to_str atom_keys

    assert str_keys["two"]["three"] == 3
  end

  test "&to_str/1 works with nested Lists" do
    atom_keys = %{one: 1, two: [%{three: 3}]}
    str_keys = Keys.to_str atom_keys

    assert str_keys["two"] == [%{"three" => 3}]
  end

  test "&to_snake/1 converts all string keys to snake_case" do
    camel_keys = %{"someKey" => 1}
    snake_keys = Keys.to_snake camel_keys

    assert snake_keys["some_key"] == 1
  end
end
