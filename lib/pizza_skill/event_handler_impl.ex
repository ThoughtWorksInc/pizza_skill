defimpl PizzaSkill.EventHandler, for: Any do
  def start_order(order, request), do: order
  def add_item(order, request), do: order
  def remove_item(order, request), do: order
  def confirm_order(order, request), do: order
end
