defmodule Medium.QueryTest do
  use ExUnit.Case, async: true

  alias Medium.Helpers.Query

  test "delegates the encoding of simple structures to URI.encode_query/1" do
    simple_query = %{one: 1, two: 2}
    encoded_query = Query.encode(simple_query)

    assert encoded_query == URI.encode_query(simple_query)
  end

  test "encodes lists" do
    complex_query = %{one: ["one", "uno"]}
    encoded_query = Query.encode(complex_query)

    assert encoded_query == "one=one%2Cuno"
  end
end
