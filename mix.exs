defmodule PizzaSkill.Mixfile do
  use Mix.Project

  def project do
    [app: :pizza_skill,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "Allows you to order a pizza.",
     package: package,
     deps: deps]
  end

  def package do
    [
      maintainers: ["Colin Harris", "Aloysius Ang"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://bitbucket.org/Col/pizza_skill"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :alexa]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:alexa, "~> 0.1.10"},
      {:poison, "~> 2.0"},
      {:inflex, "~> 1.5.0"}
    ]
  end
end
