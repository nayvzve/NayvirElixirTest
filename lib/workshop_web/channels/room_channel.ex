defmodule WorkshopWeb.RoomChannel do
  use WorkshopWeb, :channel

    alias Workshop.Chat
    require Logger

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
 def handle_in("shout", %{"user_name" => user, "user_message" => message} = payload,socket) do

# se creo una funcion para cambiar el texto grosero
   nuevoMsj =  String.split(message, " ")
    |>censurado("")


   case Chat.create_log(%{user: user, message: nuevoMsj}) do
     {:ok, _} ->
         #se redefinio el valor de payload para que cargara directamente en el chat
       payload =  %{"user_name" => user, "user_message" => nuevoMsj}
       broadcast socket, "shout", payload



     {:error, _} ->
       Logger.info("Error saving with payload: #{inspect payload}")
   end
   {:noreply, socket}
 end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
    def censurado([head | tail], texto) do

        words =   ["gonorrea", "maldi", "puta" , "puto", "verga", "malparido", "pichurria", "guevon", "hijoeputa", "maric"]
        if Enum.member?(words, head) do
            censurado(tail, texto <> " " <> "#$%^#$%")
        else
            censurado(tail, texto <> " " <> head)
        end
    end

    def censurado([], texto) do
        texto
    end
end
