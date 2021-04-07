defmodule ListLengthTest do
  use ExUnit.Case

  describe "call/1" do
    test "calculates the list length" do
      current_list = [1, 2, 3, 5, 7]

      response = ListLength.call(current_list)

      expected_response = {:ok, 5}

      assert response == expected_response
    end

    test "returns an error when an invalid list is provided" do
      response = ListLength.call("banana")

      expected_response = {:error, "Argumento fornecido não é uma lista válida!"}

      assert response === expected_response
    end
  end
end
