defmodule PdfExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :pdf_example,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:pdf_generator, ">=0.4.0"},
      {:sneeze, "~> 1.1"}
    ]
  end
end