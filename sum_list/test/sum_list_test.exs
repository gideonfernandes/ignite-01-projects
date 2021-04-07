defmodule SumListTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the list sum" do
      list = [1, 2, 3]

      response = SumList.call(list)

      expected_response = 6

      assert response == expected_response
    end

    test "returns 0 when there is an empty list" do
      list = []

      response = SumList.call(list)

      expected_response = 0

      assert response == expected_response
    end
  end
end
