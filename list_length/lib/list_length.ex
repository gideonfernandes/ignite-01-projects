defmodule ListLength do
  def call(list) when is_list(list), do: sum_length(list, 0)

  def call(_), do: {:error, "Argumento fornecido não é uma lista válida!"}

  defp sum_length([], acc), do: {:ok, acc}

  defp sum_length([_head | tail], acc) do
    acc = acc + 1

    sum_length(tail, acc)
  end
end
