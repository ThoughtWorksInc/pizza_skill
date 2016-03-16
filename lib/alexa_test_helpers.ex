defmodule Alexa.TestHelpers do
  alias Alexa.{Request, Session, RequestElement, Intent}

  def intent_request(app_id, intent_name, user_id, slot_values \\ %{}, attributes \\ %{}) do
    slots = Enum.reduce(slot_values, %{}, fn({k, v}, slots) -> Map.put(slots, k, %{ "name" => k, "value" => v }) end)
    %Request{
      session: %Session{
        user: %{ "userId" => user_id },
        attributes: attributes,
        application: %{ applicationId: app_id }
      },
      request: %RequestElement{
        intent: %Intent{
          name: intent_name,
          slots: slots
        },
        type: "IntentRequest"
      }
    }
  end

end
