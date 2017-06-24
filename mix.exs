defmodule FormexVex.Mixfile do
  use Mix.Project

  def project do
    [app: :formex_vex,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     description: description(),
     docs: [main: "readme",
          extras: ["README.md"]],
     source_url: "https://github.com/jakub-zawislak/formex_vex",
     elixirc_paths: elixirc_paths(Mix.env),
     aliases: aliases()
    ]
  end

  def application do
    []
  end

  defp deps do
    deps = [{:vex, "~> 0.6.0"}]

    if Mix.env == :prod do
      deps ++ {:formex, "~> 0.5.0", only: :dev}
    else # because of jakub-zawislak/phoenix-forms
      deps
    end
  end

  defp description do
    """
    Vex validator adapter for Formex
    """
  end

  defp package do
    [maintainers: ["Jakub Zawiślak"],
     licenses: ["MIT"],
     files: ~w(lib LICENSE.md mix.exs README.md),
     links: %{github: "https://github.com/jakub-zawislak/formex"}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    ["test": ["ecto.migrate", "test"]]
  end
end
