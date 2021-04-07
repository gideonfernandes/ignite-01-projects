defmodule ListFilter do
  require Integer

  def call(list) when is_list(list), do: get_odd_numbers(list)
  def call(_), do: {:error, "Argumento fornecido não é uma lista válida!"}

  defp get_odd_numbers(list) do
    Stream.filter(list, fn value -> String.valid?(value) and !Kernel.is_integer(value) end)
    |> Stream.filter(fn value -> is_parsed_integer?(Integer.parse(value)) end)
    |> Enum.map(&String.to_integer/1)
    |> merge_lists(list)
    |> Stream.uniq()
    |> Enum.filter(&Integer.is_odd/1)
    |> sum_length(0)
  end

  defp merge_lists(numbers_list, list), do: numbers_list ++ extract_integers(list)
  defp extract_integers(list), do: Enum.filter(list, &Kernel.is_integer/1)

  defp is_parsed_integer?({_number, ""}), do: true
  defp is_parsed_integer?(_), do: false

  defp sum_length([], acc), do: {:ok, acc}
  defp sum_length([_head | tail], acc), do: sum_length(tail, acc + 1)
end
