defmodule PizzaSkill do
  use Alexa.Skill, app_id: Application.get_env(:pizz_skill, :app_id)
  alias PizzaSkill.{Order, EventHandler}
  alias Alexa.{Request, Response}

  def handle_intent("StartOrder", _, response) do
    EventHandler.start_order(%Order{})
    response
      |> say("Certainly, what kind of pizza would you like?")
      |> should_end_session(false)
  end

  def handle_intent("AddToOrder", request, response) do
    order = get_order(request)
      |> add_items(request)
      |> add_items(request, "two")
      |> EventHandler.add_item
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
        EventHandler.confirm_order(get_order(request))
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

  defp add_items(order, request, suffix \\ "") do
    item = Request.slot_value(request, "item"<>suffix)
    qty = Request.slot_value(request, "quantity"<>suffix)
    Order.add_item(order, item, qty)
  end

end
