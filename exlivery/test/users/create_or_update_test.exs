defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe("call/1") do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "saves the user when all params are valid" do
      params = %{
        name: "Gideon Fernandes",
        email: "gideon@gmail.com",
        cpf: "12345678900",
        age: 22,
        address: "Rua das Bananeiras"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "returns an error when there are invalid params" do
      params = %{
        name: "Gideon Fernandes",
        email: "gideon@gmail.com",
        cpf: "12345678900",
        age: 17,
        address: "Rua das Bananeiras"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
