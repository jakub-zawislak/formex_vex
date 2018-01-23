defmodule Formex.Validator.Vex.Mixfile do
  use Mix.Project

  def project do
    [app: :formex_vex,
     version: "0.1.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package(),
     description: description(),
     docs: [main: "readme",
          extras: ["README.md"]],
     source_url: "https://github.com/jakub-zawislak/formex_vex",
     elixirc_paths: elixirc_paths(Mix.env)
    ]
  end

  def application do
    []
  end

  defp deps do
    deps = [
      {:vex, "~> 0.6.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]

    if !System.get_env("FORMEX_DEV") do
      deps ++ [{:formex, ">= 0.5.0 and < 0.7.0"}]
    else
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
     links: %{github: "https://github.com/jakub-zawislak/formex_vex"}]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
