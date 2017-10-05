# [Vex](https://github.com/CargoSense/vex) validator adapter for Formex

## Installation

```elixir
def deps do
  [{:formex_vex, "~> 0.1.0"}]
end
```

`config/config.exs`
```elixir
config :formex,
  validator: Formex.Validator.Vex
```

See [Formex.Validator docs](https://hexdocs.pm/formex/Formex.Validator.html) for more info

## Usage

```elixir
  def build_form(form) do
    form
    |> add(:name, :text_input, validation: [presence: :true, length: [in: 10..150]])
    |> add(:content, :textarea, validation: [presence: [message: "can't be blank"]])
    |> add(:slug, :text_input, validation: fn (text) ->
      if !Repo.get_by(Article, slug: text) do
        :ok
      else
        {:error, "already used!!1"}
      end
    end)
    # ...
  end
```

See [Vex documentation](https://github.com/CargoSense/vex#supported-validations) for more options
