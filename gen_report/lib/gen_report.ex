defmodule GenReport do
  alias GenReport.{Calculator, Parser}

  @freelancers [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  @months [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  ]

  @years ["2016", "2017", "2018", "2019", "2020"]

  def build(filename) do
    result =
      filename
      |> Parser.parse_file()
      |> Enum.reduce(report_acc(), fn line, report -> Calculator.sum_values(line, report) end)

    {:ok, result}
  end

  def build_report(hours, months, years) do
    %{"all_hours" => hours, "hours_per_month" => months, "hours_per_year" => years}
  end

  defp report_acc do
    all_hours_acc()
    |> build_report(hours_per_month_acc(), hours_per_year_acc())
  end

  defp all_hours_acc, do: Enum.into(@freelancers, %{}, &{&1, 0})
  defp hours_per_month_acc, do: Enum.into(@freelancers, %{}, &{&1, months_acc_for_freelancer()})
  defp hours_per_year_acc, do: Enum.into(@freelancers, %{}, &{&1, years_acc_for_freelancer()})
  defp months_acc_for_freelancer, do: Enum.into(@months, %{}, &{&1, 0})
  defp years_acc_for_freelancer, do: Enum.into(@years, %{}, &{&1, 0})
end
