defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns all odd numbers from the list provided" do
      current_list = ["1", "3", "6", "43", "banana", "6", "abc"]

      response = ListFilter.call(current_list)

      expected_response = {:ok, 3}

      assert response == expected_response
    end

    test "returns an error when an invalid list is provided" do
      response = ListFilter.call("banana")

      expected_response = {:error, "Argumento fornecido não é uma lista válida!"}

      assert response == expected_response
    end
  end
end
