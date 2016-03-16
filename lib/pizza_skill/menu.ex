defmodule PizzaSkill.Menu do
  alias PizzaSkill.Menu
  alias PizzaSkill.MenuItem

  defstruct [:pizzas, :salads]

  def menu do
    %Menu{
      pizzas: [
        MenuItem.anna_pizza,
        MenuItem.barbara_pizza,
        MenuItem.claudia_pizza,
        MenuItem.donna_pizza
      ],
      salads: [
        MenuItem.cesare_salad,
        MenuItem.caprese_salad
      ]
    }
  end

end
