# Medium SDK for Elixir(WIP)

An Elixir SDK for the Medium.com API.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `medium_client` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:medium_client, "~> 0.1.0"}]
    end
    ```

  2. Ensure `medium_client` is started before your application:

    ```elixir
    def application do
      [applications: [:medium_client]]
    end
    ```

## Licence

All the code contained in this repository, unless explicitly stated, is licensed under an MIT license.

A copy of the license can be found in the [LICENSE](LICENSE) file.