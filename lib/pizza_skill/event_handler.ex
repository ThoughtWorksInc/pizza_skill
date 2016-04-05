defprotocol PizzaSkill.EventHandler do
  @fallback_to_any true
  def start_order(order)
  def add_item(order)
  def remove_item(order)
  def confirm_order(order)
end
