defmodule FastGenReport.Calculator do
  def sum_values(line, report) do
    calc_hours_by_period(line, report, :all)
    |> FastGenReport.build_report(
      calc_hours_by_period(line, report, :month),
      calc_hours_by_period(line, report, :year)
    )
  end

  def sum_reports(report, result) do
    merge_maps(report["all_hours"], result["all_hours"])
    |> FastGenReport.build_report(
      merge_by_period(report["hours_per_month"], result["hours_per_month"]),
      merge_by_period(report["hours_per_year"], result["hours_per_year"])
    )
  end

  defp merge_maps(m1, m2), do: Map.merge(m1, m2, fn _key, v1, v2 -> v1 + v2 end)
  defp merge_by_period(m1, m2), do: Map.merge(m1, m2, fn _key, v1, v2 -> merge_maps(v1, v2) end)

  defp calc_all_hours({all_hours, current_name, amount_hours}) do
    all_hours
    |> Map.put(current_name, all_hours[current_name] + amount_hours)
  end

  defp calc_hours_by_month({hours_per_month, name, amount_hours, month}) do
    hours_per_month
    |> Kernel.put_in([name, month], hours_per_month[name][month] + amount_hours)
  end

  defp calc_hours_by_year({hours_per_year, name, amount_hours, year}) do
    hours_per_year
    |> Kernel.put_in([name, year], hours_per_year[name][year] + amount_hours)
  end

  defp calc_hours_by_period(line, report, :all = _option) do
    {report["all_hours"], line["name"], line["amount_hours"]}
    |> calc_all_hours()
  end

  defp calc_hours_by_period(line, report, :month = _option) do
    {report["hours_per_month"], line["name"], line["amount_hours"], line["month"]}
    |> calc_hours_by_month()
  end

  defp calc_hours_by_period(line, report, :year = _option) do
    {report["hours_per_year"], line["name"], line["amount_hours"], line["year"]}
    |> calc_hours_by_year()
  end
end
