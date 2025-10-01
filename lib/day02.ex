defmodule AoC.Day02 do
  @separator " "

  def input(fname) do
    File.stream!(fname)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(fn line ->
      line
      |> String.split(@separator, trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.to_list()
  end

  def safe?(levels) when length(levels) <= 1, do: true
  def safe?(levels) do
    diffs = Enum.zip(levels, tl(levels)) |> Enum.map(fn {a, b} -> b - a end)
    inc? = Enum.all?(diffs, &(&1 in 1..3))
    dec? = Enum.all?(diffs, &(&1 in -3..-1))
    inc? or dec?
  end

  def safe_with_dampener?(levels) do
    safe?(levels) or Enum.any?(0..length(levels)-1, fn i ->
      safe?(List.delete_at(levels, i))
    end)
  end

  def run(fname) do
    input(fname)
    |> Enum.map(&safe_with_dampener?/1)
    |> Enum.frequencies()
  end
end
