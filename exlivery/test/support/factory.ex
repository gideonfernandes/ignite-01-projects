defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User
  alias Faker.{Address, Code, Internet, Person}

  def user_factory do
    %User{
      name: Person.name(),
      email: Internet.email(),
      cpf: Code.isbn10(),
      age: Enum.random([18, 19, 20, 21, 22]),
      address: Address.PtBr.street_address()
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de Peperoni",
      category: :pizza,
      quantity: 1,
      unit_price: Decimal.new("35.5")
    }
  end

  def order_factory do
    %Order{
      delivery_address: Address.PtBr.street_address(),
      items: [
        build(:item),
        build(:item,
          description: "Temaki de Atum",
          category: :japonesa,
          quantity: 2,
          unit_price: Decimal.new("52.25")
        )
      ],
      total_price: Decimal.new("140.00"),
      user_cpf: "12345678900"
    }
  end
end
