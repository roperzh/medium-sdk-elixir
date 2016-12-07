defmodule Medium.Helpers.Query do
  @moduledoc """
  This module helps encoding lists in query parameters, as this operation
  is not supported by the standard library.
  """

  alias Medium.Helpers.Keys

  @doc """
  This function is a simple wrapper around `URI.encode_query/1`, but with
  a little tweak in order to accept lists as parameters.

  ## Example
      Medium.Helpers.Query.encode(%{one: ["one", "uno"]})
      # => "one=one%2Cuno"
  """
  def encode(query) do
    query
    |> Keys.to_str
    |> Enum.map(&encoder/1)
    |> Enum.join("&")
  end

  @docp """
  Encode a tuple into a query string, when the parameter is a list,
  join the values with commas, otherwhise encode as the function would normally
  do.
  """
  defp encoder({key, value}) when is_list(value) do
    URI.encode_query(%{key => Enum.join(value, ",")})
  end

  defp encoder({key, value}) do
    URI.encode_query(%{key => value})
  end
end
