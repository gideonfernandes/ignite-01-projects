defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  describe("save/1") do
    test "saves the order" do
      OrderAgent.start_link(%{})

      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe("get/1") do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "returns the order when the order is found" do
      {:ok, uuid} =
        :order
        |> build()
        |> OrderAgent.save()

      assert {:ok, _order} = OrderAgent.get(uuid)
    end

    test "returns an error if the user is not found" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end
end
