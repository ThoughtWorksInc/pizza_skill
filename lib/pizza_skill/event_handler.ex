defprotocol PizzaSkill.EventHandler do
  @fallback_to_any true
  def start_order(order, request)
  def add_item(order, request)
  def remove_item(order, request)
  def confirm_order(order, request)
end
