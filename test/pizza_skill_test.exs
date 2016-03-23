defmodule PizzaSkillTest do
  use Pavlov.Case, async: true
  # import Pavlov.Syntax.Expect
  alias PizzaSkill.{Order, LineItem}
  import Alexa.Response
  import Alexa.TestHelpers
  doctest PizzaSkill

  @app_id "test-app-id"

  def create_request(intent_name, slot_values \\ %{}, attributes \\ %{}) do
    intent_request("test-app-id", intent_name, nil, slot_values, attributes)
  end

  test "StartOrder" do
    request = create_request("StartOrder")
    response = Alexa.handle_request(request)
    assert "Certainly, what kind of pizza would you like?" = say(response)
    refute should_end_session(response)
  end

  test "AddToOrder - add the first item" do
    slot_values = %{ "item" => "Meat Lovers" }
    request = create_request("AddToOrder", slot_values)
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
    request = create_request("AddToOrder", slot_values, attributes)
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

  context "with an existing order" do

    describe "adding more items" do

    end

    context "when asked for anything else?" do

    end

    context "when asked to confirm the order?" do

    end

    context "when these is no active question" do

      describe "yes" do
        let :request, do: PizzaSkillTest.create_request("AMAZON.YesIntent")
        subject do: Alexa.handle_request(request)

        it "should respond with a question" do
          assert "Your sphincter says what?" = say(subject)
        end

        it "should not end the session" do
          refute should_end_session(subject)
        end
      end

    end

  end

  test "AMAZON.YesIntent - anything else?" do
    order = %Order{ items: [
      %LineItem{ name: "Meat Lovers", qty: 1 }
    ]}
    request = create_request("AMAZON.YesIntent", %{}, %{
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
    request = create_request("AMAZON.YesIntent", %{}, %{
      "order" => order,
      "question" => "ConfirmOrder"
    })
    response = Alexa.handle_request(request)

    assert "Ok. Your pizza has been ordered and will arrive in about thirty five minutes." = say(response)
    assert should_end_session(response)
  end

  test "AMAZON.NoIntent - when there is no question" do
    request = create_request("AMAZON.NoIntent")
    response = Alexa.handle_request(request)

    assert "Your sphincter says what?" = say(response)
    refute should_end_session(response)
  end

  test "AMAZON.NoIntent - anything else?" do
    order_map = %{ "items" => [ %{ "name" => "Meat Lovers", "qty" => 1 } ]}
    request = create_request("AMAZON.NoIntent", %{}, %{
      "order" => order_map,
      "question" => "AnythingElse"
    })
    response = Alexa.handle_request(request)

    expected_order = Order.from_map(order_map)
    assert ^expected_order = attribute(response, "order")
    assert "ConfirmOrder" = attribute(response, "question")
    assert "Shall I place the order now?" = say(response)
    refute should_end_session(response)
  end

  test "AMAZON.NoIntent - confirm order" do
    order_map = %{ "items" => [ %{ "name" => "Meat Lovers", "qty" => 1 } ]}
    request = create_request("AMAZON.NoIntent", %{}, %{
      "order" => order_map,
      "question" => "ConfirmOrder"
    })
    response = Alexa.handle_request(request)

    expected_order = Order.from_map(order_map)
    assert ^expected_order = attribute(response, "order")
    assert "AnythingElse" = attribute(response, "question")
    assert "What else would you like?" = say(response)
    refute should_end_session(response)
  end

end
