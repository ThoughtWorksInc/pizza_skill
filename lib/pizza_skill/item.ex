defmodule PizzaSkill.Item do

  def new(name, qty \\ 1) do
    %{ "name" => name, "quantity" => qty || 1 }
  end

  def name(item) do
    Map.get(item, "name")
  end

  def quantity(item) do
    Map.get(item, "quantity")
  end

end
