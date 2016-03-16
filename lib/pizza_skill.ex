defmodule PizzaSkill do
  use Alexa.Skill, app_id: "unknown"
  alias PizzaSkill.Order
  alias Alexa.{Request, Response}

  def handle_intent("StartOrder", _, response) do
    response
      |> say("Certainly, what kind of pizza would you like?")
      |> should_end_session(false)
  end

  def handle_intent("AddToOrder", request, response) do
    order = get_order(request) |> add_items(request)
    response
      |> Response.set_attribute("order", order)
      |> say("Certainly")
      |> should_end_session(false)
  end

  defp get_order(request) do
    Request.attribute(request, "order") || %{}
  end

  defp add_items(order, request) do
    item = Request.slot_value(request, "item1")
    qty = Request.slot_value(request, "quantity1")
    Order.add_item(order, item, qty)
  end

end
