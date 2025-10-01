defmodule AoC.Day03 do

  @mul ~r/mul\((\d{1,3}),(\d{1,3})\)/
  #@dos ~r/don't\(\)(.*?)do\(\)/s
  @tok ~r/don't\(\)|do\(\)|mul\((\d{1,3}),(\d{1,3})\)/

  def input(fname) do
    File.read!(fname)
  end

  def part1(input) do
    Regex.scan(@mul, input)
      |> Enum.reduce(0, fn [_, a, b], acc ->
        acc + String.to_integer(a) * String.to_integer(b)
      end)
  end

  def part2(input) do
    Regex.scan(@tok, input, capture: :all)
      |> Enum.reduce({0, true}, fn
        ["do()"],    {acc, _} -> {acc, true}
        ["don't()"], {acc, _} -> {acc, false}
        [_, a, b],   {acc, true} -> {acc + String.to_integer(a) * String.to_integer(b), true}
        [_, _, _],   acc_state -> acc_state
      end)
      |> elem(0)
  end

#  def calculate(input) do
#    input =
#      input |>
#      String.replace(@dos, "", global: true)
#
#    Regex.scan(@mul, input)
#      |> Enum.reduce(0, fn [_, a, b], acc ->
#        acc + String.to_integer(a) * String.to_integer(b)
#      end)
#  end

  def run(fname) do
    fname |> input |> part2
  end

end
