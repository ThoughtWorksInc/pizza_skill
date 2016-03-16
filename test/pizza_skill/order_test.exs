defmodule PizzaSkill.OrderTest do
  use ExUnit.Case
  alias PizzaSkill.{Order, LineItem}
  import PizzaSkill.Order

  test "from_map" do
    order_map = %{ "items" => [ %{ "name" => "Meat Lovers", "qty" => 1 } ] }
    order = from_map(order_map)
    assert %Order{ items: [%LineItem{name: "Meat Lovers", qty: 1}] } = order
  end

  test "from_json - with an item" do
    json = ~s({ "items": [ { "name": "Meat Lovers", "qty": 1 } ] })
    order = from_json(json)
    assert %Order{ items: [%LineItem{name: "Meat Lovers", qty: 1}] } = order
  end

  test "from_json - without an item" do
    json = ~s({ "items": [ ] })
    order = from_json(json)
    assert %Order{ items: [] } = order
  end

  test "to_json" do
    order = %Order{ items: [%LineItem{name: "Meat Lovers", qty: 1}] }
    json = to_json(order)
    assert "{\"items\":[{\"qty\":1,\"name\":\"Meat Lovers\"}]}" = json
  end

  test "num_items - when items is undefined" do
    assert 0 = num_items(%Order{})
  end

  test "num_items - when items is nil" do
    assert 0 = num_items(%Order{ items: nil })
  end

  test "num_items - when there's 0 items" do
    assert 0 = num_items(%Order{ items: [] })
  end

  test "num_items - when there's 1 item" do
    assert 1 = num_items(%Order{ items: [ %LineItem{} ] })
  end

  test "say - with one item" do
    order = %Order{ items: [%LineItem{ name: "Meat Lovers", qty: 1 }] }
    assert "One Meat Lovers pizza." = say(order)
  end

  test "say - with two items" do
    order = %Order{ items: [
      %LineItem{ name: "Pepperoni", qty: 1 },
      %LineItem{ name: "Meat Lovers", qty: 1 }
    ]}
    assert "That's one Pepperoni pizza and one Meat Lovers pizza." = say(order)
  end

  test "say - with three items" do
    order = %Order{ items: [
      %LineItem{ name: "Pepperoni", qty: 1 },
      %LineItem{ name: "Meat Lovers", qty: 2 },
      %LineItem{ name: "Hawaiian", qty: 3 }
    ]}
    assert "That's one Pepperoni pizza, two Meat Lovers pizzas and three Hawaiian pizzas." = say(order)
  end

end
