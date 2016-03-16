defmodule PizzaSkill.Utils do
  import String

  # TODO: find a better implementation later.
  def num_to_words(1), do: "one"
  def num_to_words(2), do: "two"
  def num_to_words(3), do: "three"

  def capitalize_sentence(string) do
    upcase(first(string)) <> slice(string, 1..String.length(string))
  end

end
