defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  describe("save/1") do
    test "saves the user" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe("get/1") do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "returns the user when the user is found" do
      :user
      |> build(
        address: "Jardim Thiago, 059",
        age: 22,
        cpf: "12345678900",
        email: "alfonzo.tromp@farrell.net",
        name: "Jodie Conroy"
      )
      |> UserAgent.save()

      response = UserAgent.get("12345678900")

      expected_response =
        {:ok,
         %Exlivery.Users.User{
           address: "Jardim Thiago, 059",
           age: 22,
           cpf: "12345678900",
           email: "alfonzo.tromp@farrell.net",
           name: "Jodie Conroy"
         }}

      assert response == expected_response
    end

    test "returns an error if the user is not found" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
