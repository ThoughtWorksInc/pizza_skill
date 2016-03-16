defmodule PizzaSkillTest do
  use ExUnit.Case
  alias PizzaSkill.{Order, LineItem}
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

    assert %Order{
      items: [ %LineItem{ name: "Meat Lovers", qty: 1 } ]
    } = attribute(response, "order")
  end

  test "AddToOrder - with a single item - responds correctly" do
    slot_values = %{ "item1" => "Meat Lovers" }
    request = intent_request(@app_id, "AddToOrder", @user_id, slot_values)
    response = Alexa.handle_request(request)

    assert "Certainly. One Meat Lovers pizza. Shall I place the order now?" = say(response)
    refute should_end_session(response)
  end

end
