defmodule Budgets.DashboardView do
  use Budgets.Web, :view

   def render("index.json", %{balances: balances}) do
    %{balances: render_many(balances, Budgets.BalanceView, "balance.json")}
   end
end
