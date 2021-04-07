defmodule GenReport.Parser do
  def parse_file(filename) do
    filename
    |> File.stream!()
    |> Stream.map(fn line -> parse_line(line) end)
    |> convert_data()
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
  end

  defp convert_data(list), do: Stream.map(list, fn line -> convert_line(line) end)

  defp convert_line([name, hours, _day, month, year]) do
    hours = String.to_integer(hours)

    %{"name" => name, "amount_hours" => hours, "month" => convert_month(month), "year" => year}
  end

  defp convert_month(_month = "1"), do: "janeiro"
  defp convert_month(_month = "2"), do: "fevereiro"
  defp convert_month(_month = "3"), do: "março"
  defp convert_month(_month = "4"), do: "abril"
  defp convert_month(_month = "5"), do: "maio"
  defp convert_month(_month = "6"), do: "junho"
  defp convert_month(_month = "7"), do: "julho"
  defp convert_month(_month = "8"), do: "agosto"
  defp convert_month(_month = "9"), do: "setembro"
  defp convert_month(_month = "10"), do: "outubro"
  defp convert_month(_month = "11"), do: "novembro"
  defp convert_month(_month = "12"), do: "dezembro"
  defp convert_month(_month = _), do: "Mês inválido"
end
