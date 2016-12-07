defmodule Medium.Helpers.KeysMacros do
  defmacro __using__(_) do
    quote do
      import Medium.Helpers.KeysMacros
    end
  end
  
  defmacro key_function(name, function) do
    quote do
      def unquote(name)(map) when is_map(map) do
        for {key ,val} <- map,
          into: %{},
          do: {unquote(function).(key), unquote(name)(val)}
      end

      def unquote(name)(list) when is_list(list) do
        Enum.map list, &__MODULE__.unquote(name)/1
      end

      def unquote(name)(val), do: val
    end
  end
end
