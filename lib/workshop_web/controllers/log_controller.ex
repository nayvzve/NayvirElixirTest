defmodule WorkshopWeb.LogController do
   use WorkshopWeb, :controller

   alias Workshop.Chat
   alias Workshop.Chat.Log

    def censura(a) do
       words = Poison.encode!([:gonorrea, :maldi, :puta ], pretty: true)
        IO.puts a

    end

   def index(conn, _params) do
       logs = Chat.list_logs()
       a = [1, 2]
           censura(a)
       render(conn, "index.html", logs: logs)
   end
end
