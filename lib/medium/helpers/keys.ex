defmodule Medium.Helpers.Keys do
  use Medium.Helpers.KeysMacros

  key_function :to_str, &Atom.to_string/1

  key_function :to_atom, &String.to_atom/1

  key_function :to_snake, &Macro.underscore/1
end
