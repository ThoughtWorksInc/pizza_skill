defmodule PizzaSkillTest do
  use Pavlov.Case, async: true
  import Alexa.Response
  alias PizzaSkill.{Order, LineItem}
  alias Alexa.Request
  doctest PizzaSkill

  @app_id "test-app-id"

  def create_request(intent_name, slot_values \\ %{}, attributes \\ %{}) do
    Request.intent_request("test-app-id", intent_name, nil, slot_values, attributes)
  end

  context "with no existing order" do

    describe "launching the skill" do
      let :request, do: PizzaSkillTest.create_request("StartOrder")
      subject do: Alexa.handle_request(request)

      it "should respond with a greating" do
        assert "Certainly, what kind of pizza would you like?" = say(subject)
      end
      it "should leave the session open" do
        refute should_end_session(subject)
      end
    end

    describe "adding a single item with no quantity" do
      let :request, do: PizzaSkillTest.create_request("AddToOrder", %{ "item" => "Meat Lovers" })
      subject do: Alexa.handle_request(request)

      it "should create a new order with the correct item" do
        expected_order = %Order{ items: [ %LineItem{ name: "Meat Lovers", qty: 1 } ] }
        assert ^expected_order = attribute(subject, "order")
      end

      it "should repeat the order and ask if the user wants anything else" do
        assert "Ok. One Meat Lovers pizza. Anything else?" = say(subject)
        assert "AnythingElse" = attribute(subject, "question")
      end

      it "should leave the session open" do
        refute should_end_session(subject)
      end
    end

    describe "adding an item with a quantity of two" do
      let :request, do: PizzaSkillTest.create_request("AddToOrder", %{ "item" => "Meat Lovers", "quantity" => 2 })
      subject do: Alexa.handle_request(request)

      it "should create a new order with the correct item and quantity" do
        expected_order = %Order{ items: [ %LineItem{ name: "Meat Lovers", qty: 2 } ] }
        assert ^expected_order = attribute(subject, "order")
      end

      it "should repeat the order and ask if the user wants anything else" do
        assert "Ok. Two Meat Lovers pizzas. Anything else?" = say(subject)
        assert "AnythingElse" = attribute(subject, "question")
      end

      it "should leave the session open" do
        refute should_end_session(subject)
      end
    end

    describe "adding multiple items" do
      let :request do
        PizzaSkillTest.create_request(
          "AddToOrder",
          %{
            "item" => "Meat Lovers",
            "itemtwo" => "Hawaiian", "quantitytwo" => 2
          }
        )
      end
      subject do: Alexa.handle_request(request)

      it "should create a new order with the correct items and quantities" do
        expected_order = %Order{ items: [
          %LineItem{ name: "Meat Lovers", qty: 1 },
          %LineItem{ name: "Hawaiian", qty: 2 }
        ] }
        assert ^expected_order = attribute(subject, "order")
      end

      it "should repeat the order and ask if the user wants anything else" do
        assert "Ok. That's one Meat Lovers pizza and two Hawaiian pizzas. Anything else?" = say(subject)
        assert "AnythingElse" = attribute(subject, "question")
      end

      it "should leave the session open" do
        refute should_end_session(subject)
      end
    end

  end

  context "with an existing order" do
    let :order do
      %PizzaSkill.Order{ items: [ %PizzaSkill.LineItem{ name: "Meat Lovers", qty: 1 } ]}
    end

    describe "add a single item to an existing order" do
      let :request do
        PizzaSkillTest.create_request(
          "AddToOrder",
          %{ "item" => "Hawaiian", "quantity" => 2 },
          %{ "order" => PizzaSkill.Order.to_map(order) }
        )
      end
      subject do: Alexa.handle_request(request)

      it "should the the new item to the existing order" do
        expected_order = %Order{ items: [
          %LineItem{ name: "Meat Lovers", qty: 1 },
          %LineItem{ name: "Hawaiian", qty: 2 }
        ] }
        assert ^expected_order = attribute(subject, "order")
      end

      it "should repeat the complete order and ask the user if they want anything else" do
        assert "Ok. That's one Meat Lovers pizza and two Hawaiian pizzas. Anything else?" = say(subject)
        assert "AnythingElse" = attribute(subject, "question")
      end

      it "should leave the session open" do
        refute should_end_session(subject)
      end
    end

    context "when asked for anything else?" do

      describe "yes" do
        let :request do
          PizzaSkillTest.create_request("AMAZON.YesIntent", %{}, %{ "order" => PizzaSkill.Order.to_map(order), "question" => "AnythingElse" })
        end
        subject do: Alexa.handle_request(request)

        it "should not change the order" do
          expected_order = order
          assert ^expected_order = attribute(subject, "order")
        end
        it "should ask what you would like" do
          assert "What else would you like?" = say(subject)
          assert "AnythingElse" = Alexa.Response.attribute(subject, "question")
        end
        it "should not end the session" do
          refute should_end_session(subject)
        end
      end

      describe "no" do
        let :request do
          PizzaSkillTest.create_request("AMAZON.NoIntent", %{}, %{ "order" => PizzaSkill.Order.to_map(order), "question" => "AnythingElse" })
        end
        subject do: Alexa.handle_request(request)

        it "should not change the order" do
          expected_order = order
          assert ^expected_order = attribute(subject, "order")
        end
        it "should ask the user to confirm the order" do
          assert "Shall I place the order now?" = say(subject)
          assert "ConfirmOrder" = Alexa.Response.attribute(subject, "question")
        end
        it "should not end the session" do
          refute should_end_session(subject)
        end
      end

    end

    context "when asked to confirm the order?" do

      describe "yes" do
        let :request do
          PizzaSkillTest.create_request("AMAZON.YesIntent", %{}, %{ "order" => PizzaSkill.Order.to_map(order), "question" => "ConfirmOrder" })
        end
        subject do: Alexa.handle_request(request)

        it "should tell the user the pizza has been ordered" do
          assert "Ok. Your pizza has been ordered and will arrive in about thirty five minutes." = say(subject)
        end
        it "should end the session" do
          assert should_end_session(subject)
        end
      end

      describe "no" do
        let :request do
          PizzaSkillTest.create_request("AMAZON.NoIntent", %{}, %{ "order" => PizzaSkill.Order.to_map(order), "question" => "ConfirmOrder" })
        end
        subject do: Alexa.handle_request(request)

        it "should not change the order" do
          expected_order = order
          assert ^expected_order = attribute(subject, "order")
        end
        it "should ask what else the user would like" do
          assert "What else would you like?" = say(subject)
          assert "AnythingElse" = Alexa.Response.attribute(subject, "question")
        end
        it "should not end the session" do
          refute should_end_session(subject)
        end
      end

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

      describe "no" do
        let :request, do: PizzaSkillTest.create_request("AMAZON.NoIntent")
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

end
