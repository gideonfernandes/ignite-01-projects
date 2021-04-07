defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe("create/1") do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build(items: [build(:item), build(:item, description: "Pizza de Calabresa")])
      |> OrderAgent.save()

      :order
      |> build(items: [build(:item), build(:item, description: "Pizza de Calabresa")])
      |> OrderAgent.save()

      expected_response =
        "12345678900,pizza,1, 35.5/npizza,1, 35.5/n,140.00/n" <>
          "12345678900,pizza,1, 35.5/npizza,1, 35.5/n,140.00/n"

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
