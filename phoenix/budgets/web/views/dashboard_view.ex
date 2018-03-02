defmodule Budgets.DashboardView do
  use Budgets.Web, :view

   def render("index.json", _balances) do
     balances = [%{
       category: "groc",
       budget: 999,
       balance: 900
     }, %{
       category: "hi",
       budget: 888,
       balance: 8
     }]
    %{balances: render_many(balances, Budgets.BalanceView, "balance.json")}
   end
end
