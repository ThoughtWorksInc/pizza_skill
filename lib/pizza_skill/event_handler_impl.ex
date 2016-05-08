defimpl PizzaSkill.EventHandler, for: Any do
  def login(request, response) do
    username = Alexa.Request.slot_value(request, "username") |> PizzaSkill.Utils.num_to_words
    Alexa.Response.say(response, "Hello user #{username}")
  end
  def logout(request, response) do
    Alexa.Response.say(response, "Good bye")
  end
  def logout(request, response), do: response
  def start_order(order, request), do: order
  def add_item(order, request), do: order
  def remove_item(order, request), do: order
  def confirm_order(order, request), do: order
end
