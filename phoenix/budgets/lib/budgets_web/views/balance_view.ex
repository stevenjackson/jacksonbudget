defmodule BudgetsWeb.BalanceView do
  use BudgetsWeb, :view

   def render("balance.json", %{balance: balance}) do
     %{
       category: balance.category,
       budget: balance.budget,
       balance: balance.balance
     }
   end
end

