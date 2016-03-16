defmodule PizzaSkill.MenuItem do
  alias PizzaSkill.MenuItem

  defstruct [:name, :ingredients, :price]

  def anna_pizza do
    ingredients = ["Tomato", "Mozzarella", "Bolognese Sauce", "Mixed Mushrooms"]
    %MenuItem{ name: "Anna", ingredients: ingredients, price: 22.5 }
  end

  def barbara_pizza do
    ingredients = ["Tomato", "Mozzarella", "Hot Italian Minced Pork", "Red Onions", "Olives"]
    %MenuItem{ name: "Barbara", ingredients: ingredients, price: 22.5 }
  end

  def claudia_pizza do
    ingredients = ["Tomato", "Bell Peppers", "Zucchini", "Eggplants", "Artichokes", "Mushrooms"]
    %MenuItem{ name: "Claudia", ingredients: ingredients, price: 22.0 }
  end

  def donna_pizza do
    ingredients = ["Tomato", "Mozzarella", "Artichokes", "Mushrooms", "Cooked Ham", "Olives"]
    %MenuItem{ name: "Donna", ingredients: ingredients, price: 23.0 }
  end

  # salads

  def cesare_salad do
    ingredients = ["Romaine Lettuce", "Bread Croutons", "Chicken Breast", "Caesar Dressing"]
    %MenuItem{ name: "Cesare Salad", ingredients: ingredients, price: 12.8 }
  end

  def caprese_salad do
    ingredients = ["Buffalo Mozzarella", "Tomato", "Fresh Basil", "Pesto Sauce"]
    %MenuItem{ name: "Caprese Salad", ingredients: ingredients, price: 13.5 }
  end

end
