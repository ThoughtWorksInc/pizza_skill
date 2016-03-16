defmodule PizzaSkill.Order do
  alias PizzaSkill.{Order, LineItem, Utils}

  defstruct [items: []]

  def from_map(order_map) do
    items = Map.get(order_map, "items", [])
            |> Enum.map(fn(i) -> LineItem.new(i["name"], i["qty"]) end)
    %Order{ items: items }
  end

  def from_json(json) do
    Poison.decode!(json, as: %Order{ items: [%LineItem{}] })
  end

  def to_json(order) do
    Poison.encode!(order)
  end

  def num_items(order) do
    (order.items || []) |> Enum.count
  end

  def add_item(order, name, nil) do
    add_item(order, name, 1)
  end

  def add_item(order, name, qty) do
    item = LineItem.new(name, qty)
    %{order | items: [item|order.items] }
  end

  def say(order) do
    say_items(order.items)
  end

  def say_items([item]) do
    Utils.capitalize_sentence(LineItem.say(item)) <> "."
  end

  def say_items(items) do
    "That's #{LineItem.say(items)}."
  end

end
