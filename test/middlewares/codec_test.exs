defmodule Medium.Middlewares.CodecTest do
  use ExUnit.Case, async: true

  alias Medium.Middlewares.Codec

  @moduletag utils: :codec

  test "&descompose_keys/1 returns all under the data key" do
    response = %{body: %{"data" => %{"a" => "b"}}}

    assert Codec.descompose_keys(response) == %{"a" => "b"}
  end

  test "&descompose_keys/1 just returns the contents of body in any other case" do
    response = %{body: %{"errors" => []}}

    assert Codec.descompose_keys(response) == %{"errors" => []}
  end
end
