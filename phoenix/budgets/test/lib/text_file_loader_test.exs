defmodule Budgets.TextFileLoaderTest do
  use ExUnit.Case

  setup _context do
    filename = "test_text_file_loader.txt"
    {:ok, file} = File.open filename, [:write]
    IO.binwrite file, "foo\t123\nbar\t456\t789"
    File.close(file)

    on_exit fn ->
      File.rm!(filename)
    end
    {:ok, [filename: filename] }
  end

  test "converts a file to balance maps", context do
    balances = Budgets.TextFileLoader.load_balances(context[:filename])

    [head | tail] = balances
    assert head == %{category: "foo", balance: "123", budget: 0}
    assert tail == [%{category: "bar", balance: "789", budget: "456"}]
  end
end
