defmodule PizzaSkillTest do
  use ExUnit.Case
  alias PizzaSkill.{Order, LineItem}
  import Alexa.Response
  import Alexa.TestHelpers
  doctest PizzaSkill

  @user_id "User-1"
  @app_id "amzn1.echo-sdk-ams.app.c180efd9-5985-4101-a9e2-fec9435e0cab"

  test "StartOrder" do
    request = intent_request(@app_id, "StartOrder", @user_id)
    response = Alexa.handle_request(request)
    assert "Certainly, what kind of pizza would you like?" = say(response)
    refute should_end_session(response)
  end

  test "AddToOrder - add the first item" do
    slot_values = %{ "item" => "Meat Lovers" }
    request = intent_request(@app_id, "AddToOrder", @user_id, slot_values)
    response = Alexa.handle_request(request)

    assert %Order{
      items: [ %LineItem{ name: "Meat Lovers", qty: 1 } ]
    } = attribute(response, "order")
    assert "AnythingElse" = attribute(response, "question")
    assert "Ok. One Meat Lovers pizza. Anything else?" = say(response)
    refute should_end_session(response)
  end

  test "AddToOrder - add a second item, with quantity" do
    slot_values = %{ "item" => "Hawaiian", "quantity" => "2" }
    attributes = %{ "order" => %{ "items" => [ %{ "name" => "Meat Lovers", "qty" => "1" } ] } }
    request = intent_request(@app_id, "AddToOrder", @user_id, slot_values, attributes)
    response = Alexa.handle_request(request)

    assert %Order{
      items: [
        %LineItem{ name: "Meat Lovers", qty: 1 },
        %LineItem{ name: "Hawaiian", qty: 2 }
      ]
    } = attribute(response, "order")
    assert "AnythingElse" = attribute(response, "question")
    assert "Ok. That's one Meat Lovers pizza and two Hawaiian pizzas. Anything else?" = say(response)
    refute should_end_session(response)
  end

  test "AMAZON.YesIntent - when there is no question" do
    request = intent_request(@app_id, "AMAZON.YesIntent", @user_id)
    response = Alexa.handle_request(request)

    assert "Your sphincter says what?" = say(response)
    refute should_end_session(response)
  end

  test "AMAZON.YesIntent - anything else?" do
    order = %Order{ items: [
      %LineItem{ name: "Meat Lovers", qty: 1 }
    ]}
    request = intent_request(@app_id, "AMAZON.YesIntent", @user_id, %{}, %{
      "order" => order,
      "question" => "AnythingElse"
    })
    response = Alexa.handle_request(request)

    assert "What else would you like?" = say(response)
    refute should_end_session(response)
  end

  test "AMAZON.YesIntent - confirm order" do
    order = %Order{ items: [
      %LineItem{ name: "Meat Lovers", qty: 1 }
    ]}
    request = intent_request(@app_id, "AMAZON.YesIntent", @user_id, %{}, %{
      "order" => order,
      "question" => "ConfirmOrder"
    })
    response = Alexa.handle_request(request)

    assert "Ok. Your pizza has been ordered and will arrive in about thirty five minutes." = say(response)
    assert should_end_session(response)
  end

end
