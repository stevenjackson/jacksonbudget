defmodule Budgets.DashboardController do
  use Budgets.Web, :controller

  def index(conn, _params) do
    balances = Budgets.TextFileLoader.load_balances
    render(conn, "index.json", balances: balances)
  end
end
