defmodule Budgets.DashboardController do
  use Budgets.Web, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
