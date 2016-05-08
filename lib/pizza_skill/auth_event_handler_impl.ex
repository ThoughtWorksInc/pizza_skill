defimpl PizzaSkill.AuthEventHandler, for: Any do
  def login(request, response), do: Alexa.Response.say(response, "Hello")
  def logout(request, response), do: Alexa.Response.say(response, "Good bye")
end
