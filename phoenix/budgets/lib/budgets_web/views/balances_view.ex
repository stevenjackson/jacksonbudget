defmodule BudgetsWeb.BalancesView do
  use BudgetsWeb, :view


  def render("index.json", %{balances: balances}) do
    %{balances: render_many(balances, BudgetsWeb.BalanceView, "balance.json")}
  end
end
