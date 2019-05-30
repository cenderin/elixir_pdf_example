defmodule PdfExampleTest do
  use ExUnit.Case
  doctest PdfExample

  test "greets the world" do
    assert PdfExample.hello() == :world
  end
end
