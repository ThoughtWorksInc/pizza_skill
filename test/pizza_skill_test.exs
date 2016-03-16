defmodule PizzaSkillTest do
  use ExUnit.Case
  alias PizzaSkill.{Order, Item}
  import Alexa.Response
  import Alexa.TestHelpers
  doctest PizzaSkill

  @user_id "User-1"
  @app_id "unknown"

  test "StartOrder" do
    request = intent_request(@app_id, "StartOrder", @user_id)
    response = Alexa.handle_request(request)
    assert "Certainly, what kind of pizza would you like?" = say(response)
    refute should_end_session(response)
  end

  test "AddToOrder - with a single item - adds the item to the order" do
    slot_values = %{ "item1" => "Meat Lovers" }
    request = intent_request(@app_id, "AddToOrder", @user_id, slot_values)
    response = Alexa.handle_request(request)

    order = attribute(response, "order")
    assert 1 = Order.num_items(order)
    item = Order.items(order) |> List.first
    assert "Meat Lovers" = Item.name(item)
    assert 1 = Item.quantity(item)
  end

end
