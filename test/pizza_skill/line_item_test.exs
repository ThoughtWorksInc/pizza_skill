defmodule PizzaSkill.LineItemTest do
  use ExUnit.Case
  alias PizzaSkill.LineItem
  import PizzaSkill.LineItem

  test "say - singular" do
    item = %LineItem{ name: "Pepperoni", qty: 1 }
    assert "one Pepperoni pizza" = say(item)
  end

  test "say - plural" do
    item = %LineItem{ name: "Pepperoni", qty: 2 }
    assert "two Pepperoni pizzas" = say(item)
  end


end
