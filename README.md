[![Build Status](https://travis-ci.org/roperzh/medium-sdk-elixir.svg?branch=master)](https://travis-ci.org/roperzh/medium-sdk-elixir)
[![Coverage Status](https://coveralls.io/repos/github/roperzh/medium-sdk-elixir/badge.svg?branch=master)](https://coveralls.io/github/roperzh/medium-sdk-elixir?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/medium.svg)](https://hex.pm/packages/medium)
[![API Testing](https://img.shields.io/badge/API%20Test-RapidAPI-blue.svg)](https://rapidapi.com/package/Medium/functions?utm_source=MediumGithub&utm_medium=button&utm_content=Vender_GitHub)

# Medium SDK for Elixir

An Elixir SDK for the Medium.com [API](https://github.com/Medium/medium-api-docs).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `medium` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:medium, "~> 0.2"}]
    end
    ```

  2. Ensure `medium` is started before your application:

    ```elixir
    def application do
      [applications: [:medium]]
    end
    ```

## Usage

Since all Medium requests must be made with an integration token, you need
to create a new client associated with that token in order to perform requests:

```elixir
client = Medium.client("my-access-token")
```

With our client at hand, we can start making requests to the API! :boom:

```elixir
# We can perform all GET requests described on the API:
user = Medium.me(client)
user_publications = Medium.publications(client, user.id)

# And we can also publish:
post = %{
  title: "Liverpool FC",
  content_format: "html",
  content: "<h1>Liverpool FC</h1><p>You’ll never walk alone.</p>",
  canonical_url: "http://jamietalbot.com/posts/liverpool-fc",
  tags: ["football", "sport", "Liverpool"],
  publish_status: "public"
}

response = Medium.publish(client, user.id, post)
```

Don't forget to check the Medium [API](https://github.com/Medium/medium-api-docs)
or the [documentation](https://hexdocs.pm/medium/api-reference.html)
to see all available methods.


## Roadmap

- [ ] Improve the documentation
- [ ] Improve the test suite
- [ ] Remove the Tesla dependency

## Licence

All the code contained in this repository, unless explicitly stated, is licensed under an MIT license.

A copy of the license can be found in the [LICENSE](LICENSE) file.
