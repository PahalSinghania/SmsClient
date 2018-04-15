defmodule SmsClient.Messenger do
 

#Use function as follows:
# SmsClient.Messenger.send_message("+17817677045", "your phone number", "message-body")

 
 #Function to send sms
  def send_message(from, to, body) do
     message_url()
    |> HTTPoison.post!(message(from, to, body), headers())
    |> process_response()
  end



  #All private functions containing sid and auth_token

  defp process_response(%HTTPoison.Response{body: body}) do
    Poison.decode!(body, keys: :atom)
  end

  defp message(from, to, body) do
    {:form, [To: to, From: from, Body: body]}
  end

  def message_url do
    "https://api.twilio.com/2010-04-01/Accounts/AC60fbe196df066115a872f4b2c831c300/Messages.json"
  end

  # function to encode tokens
  defp headers do
    sid = "AC60fbe196df066115a872f4b2c831c300"
    auth_token = "c8810eaaf424b90ac63cb52dd14c3c49"

    encoded_token = Base.encode64("#{sid}:#{auth_token}")

    [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Authorization", "Basic " <> encoded_token}
    ]
end
end

