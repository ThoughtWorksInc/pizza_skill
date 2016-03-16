defmodule PizzaSkill.OrderTest do
  use ExUnit.Case
  import PizzaSkill.Order

  test "num_items - when items is undefined" do
    assert 0 = num_items(%{})
  end

  test "num_items - when items is nil" do
    assert 0 = num_items(%{ "items" => nil })
  end

  test "num_items - when there's 0 items" do
    assert 0 = num_items(%{ "items" => [] })
  end

  test "num_items - when there's 1 item" do
    assert 1 = num_items(%{ "items" => [ %{} ] })
  end

end
