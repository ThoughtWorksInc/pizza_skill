defmodule PizzaSkill.LineItem do
  alias PizzaSkill.{LineItem, Utils}
  import Inflex

  defstruct [:name, qty: 1]

  def new(name) do
    %LineItem{ name: name }
  end

  def new(name, qty) do
    %LineItem{ name: name, qty: qty }
  end

  def say([item|[last|[]]]) do
    say(item) <> " and " <> say(last)
  end

  def say([item|tail]) do
    say(item) <> ", " <> say(tail)
  end

  def say(item) do
    "#{Utils.num_to_words(item.qty)} #{item.name} #{inflect("pizza", item.qty)}"
  end

end
