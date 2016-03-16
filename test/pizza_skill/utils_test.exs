defmodule PizzaSkill.UtilsTest do
  use ExUnit.Case
  import PizzaSkill.Utils

  test "num_to_words - one" do
    assert "one" = num_to_words(1)
  end

  test "num_to_words - two" do
    assert "two" = num_to_words(2)
  end

  test "capitalize_sentence" do
    assert "The quick Brown Fox." = capitalize_sentence("the quick Brown Fox.")
  end

end
