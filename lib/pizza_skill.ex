defmodule PizzaSkill do
  use Alexa.Skill, app_id: "amzn1.echo-sdk-ams.app.c180efd9-5985-4101-a9e2-fec9435e0cab"
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
      |> Response.set_attribute("question", "AnythingElse")
      |> say("Ok. #{Order.say(order)} Anything else?")
      |> should_end_session(false)
  end

  def handle_intent("AMAZON.YesIntent", request, response) do
    case Request.attribute(request, "question") do
      "AnythingElse" ->
        response
          |> Response.set_attribute("order", get_order(request))
          |> Response.set_attribute("question", "AnythingElse")
          |> say("What else would you like?")
          |> should_end_session(false)
      "ConfirmOrder" ->
        response
          |> say("Ok. Your pizza has been ordered and will arrive in about thirty five minutes.")
          |> should_end_session(true)
      _ ->
        response
          |> say("Your sphincter says what?")
          |> should_end_session(false)
    end
  end

  def handle_intent("AMAZON.NoIntent", request, response) do
    case Request.attribute(request, "question") do
      "AnythingElse" ->
        response
          |> Response.set_attribute("order", get_order(request))
          |> Response.set_attribute("question", "ConfirmOrder")
          |> say("Shall I place the order now?")
          |> should_end_session(false)
      "ConfirmOrder" ->
        response
          |> Response.set_attribute("order", get_order(request))
          |> Response.set_attribute("question", "AnythingElse")
          |> say("What else would you like?")
          |> should_end_session(false)
      _ ->
        response
          |> say("Your sphincter says what?")
          |> should_end_session(false)
    end
  end

  defp get_order(request) do
    case Request.attribute(request, "order") do
      nil -> %Order{}
      map -> Order.from_map(map)
    end
  end

  defp add_items(order, request) do
    item = Request.slot_value(request, "item")
    qty = Request.slot_value(request, "quantity")
    Order.add_item(order, item, qty)
  end

end
