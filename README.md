# PizzaSkill

**TODO: Add description**

## Examples

User: Alexa, ask mirror to order me a pizza
Alexa: Certainly, what kind of pizza would you like?
User: Get me one pepperoni pizza
Alexa: Ok. One pepperoni pizza. Anything else?
User: Yeah, can I also get a Hawaiian pizza and a bottle of coke. (TODO)
Alexa: Sure. One Pepperoni pizza, one Hawaiian and a bottle of coke. Anything else?
User: No thanks (TODO)
Alexa: Shall I place the order now? (TODO)
User: Order it to arrive tonight at 7:30pm (TODO)
Alexa: Ok. Your pizza has been ordered and will arrive in about thirty five minutes.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add pizza_skill to your list of dependencies in `mix.exs`:

        def deps do
          [{:pizza_skill, "~> 0.0.1"}]
        end

  2. Ensure pizza_skill is started before your application:

        def application do
          [applications: [:pizza_skill]]
        end
