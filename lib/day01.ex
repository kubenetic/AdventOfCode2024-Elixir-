defmodule AoC.Day01 do

  @separator "   "

  def read(fname) do
    File.stream!(fname)
      |> Stream.map(&String.trim/1)
      |> Stream.reject(&(&1 == ""))
      |> Stream.map(fn line ->
        case :binary.split(line, @separator) do
          [d1, d2] -> {String.to_integer(d1), String.to_integer(d2)}
          parts    -> raise ArgumentError, "bad line #{inspect(parts)}"
        end
      end)
      |> Enum.unzip
  end

  def calculate_distance(lst1, lst2) when length(lst1) != length(lst2) do
    raise ArgumentError, "lists must have the same length"
  end

  def calculate_distance(lst1, lst2) do
    Enum.zip(Enum.sort(lst1), Enum.sort(lst2))
      |> Enum.reduce(0, fn {d1, d2}, sum -> sum + abs(d1 - d2) end)
  end

  def calculate_similarity_score(lst1, lst2) do
    freq = Enum.frequencies(lst2)

    Enum.reduce(lst1, 0, fn num, score ->
      score + Map.get(freq, num, 0) * num
    end)
  end

end
