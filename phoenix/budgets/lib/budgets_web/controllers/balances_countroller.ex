defmodule BudgetsWeb.BalancesController do
  use BudgetsWeb, :controller

  def index(conn, _params) do
    balances = Budgets.TextFileLoader.load_balances
    render(conn, "index.json", balances: balances)
  end
end
