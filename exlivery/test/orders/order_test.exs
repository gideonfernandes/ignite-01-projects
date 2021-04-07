defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe("build/2") do
    test "returns an Order when all params are valid" do
      user = build(:user)

      items = [build(:item), build(:item), build(:item)]

      assert {:ok, _order} = Order.build(user, items)
    end

    test "returns an error when there is no items in the order" do
      user = build(:user)

      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
