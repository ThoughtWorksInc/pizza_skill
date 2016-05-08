defprotocol PizzaSkill.AuthEventHandler do
  @fallback_to_any true
  def login(request, response)
  def logout(request, response)
end
