defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe("call/1") do
    setup do
      OrderAgent.start_link(%{})
      UserAgent.start_link(%{})

      cpf = "12345678900"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Pizza de Peperoni",
        quantity: 1,
        unit_price: 35.50
      }

      item2 = %{
        category: :pizza,
        description: "Pizza de Calabresa",
        quantity: 3,
        unit_price: 25.50
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "saves the order when all params are valid", %{
      user_cpf: user_cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: user_cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "returns an error when there is no user with given cpf", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "00000000000", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "returns an error when there are invalid items", %{
      user_cpf: user_cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: user_cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "returns an error when there are no items", %{user_cpf: user_cpf} do
      params = %{user_cpf: user_cpf, items: []}

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
