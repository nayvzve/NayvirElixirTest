defmodule WorkshopWeb.LogController do
   use WorkshopWeb, :controller

   alias Workshop.Chat
   alias Workshop.Chat.Log

   def index(conn, _params) do
       logs = Chat.list_logs()
       words =  ["gonorrea", "maldi", "puta" , "coño", "verga", "malparido", "pichurria", "guevon", "hijoeputa", "maric"]
       render(conn, "index.html", logs: logs, words: words)
   end
end
