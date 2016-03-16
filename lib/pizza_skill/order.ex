defmodule PizzaSkill.Order do
  alias PizzaSkill.Item
  
  def num_items(order) do
    (items(order) || []) |> Enum.count
  end

  def items(order) do
    Map.get(order, "items", [])
  end

  def add_item(order, item, qty) do
    item = Item.new(item, qty)
    items = [item|items(order)]
    Map.put(order, "items", items)
  end

end
