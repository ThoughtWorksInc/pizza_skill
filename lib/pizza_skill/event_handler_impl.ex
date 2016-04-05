defimpl PizzaSkill.EventHandler, for: Any do
  def start_order(order), do: order
  def add_item(order), do: order
  def remove_item(order), do: order
  def confirm_order(order), do: order
end
