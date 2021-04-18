defmodule BudgetsWeb.PageController do
  use BudgetsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
