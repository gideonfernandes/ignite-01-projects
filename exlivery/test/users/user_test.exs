defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.User

  describe("build/5") do
    test "returns an user when all params are valid" do
      user = build(:user)

      [_user_struct | [address, age, cpf, email, name]] = Map.values(user)

      response = User.build(name, email, cpf, age, address)

      expected_response = {:ok, user}

      assert response == expected_response
    end

    test "returns an error when any param is invalid" do
      response = User.build("Gideon", "gideon@gmail.com", "12345678900", 17, "Rua das Bananeiras")

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
