defmodule PizzaSkill.MenuItem do
  alias PizzaSkill.MenuItem

  defstruct [:name, :ingredients, :price]

  def mushroom_pizza do
    %MenuItem{ name: "Mushroom", ingredients: [], price: 22.5 }
  end

  def margherita_pizza do
    %MenuItem{ name: "Margherita", ingredients: [], price: 22.5 }
  end

  def pepperoni_pizza do
    %MenuItem{ name: "Pepperoni", ingredients: [], price: 22.0 }
  end

  def hawaiian_pizza do
    %MenuItem{ name: "Hawaiian", ingredients: [], price: 23.0 }
  end

  def barbeque_chicken_pizza do
    %MenuItem{ name: "Barbeque Chicken", ingredients: [], price: 23.0 }
  end

  def double_cheese_pizza do
    %MenuItem{ name: "Double Cheese", ingredients: [], price: 23.0 }
  end

  def vegetarian_pizza do
    %MenuItem{ name: "Vegetarian", ingredients: [], price: 23.0 }
  end

end
