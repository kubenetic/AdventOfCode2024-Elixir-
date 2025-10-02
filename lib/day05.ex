defmodule AoC.Day05 do
  def load_ruleset(fname) do
    File.stream!(fname)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&String.split(&1, "|", trim: true))
    |> Stream.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
  end

  def load_updates(fname) do
    File.stream!(fname)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&String.split(&1, ",", trim: true))
    |> Stream.map(&Enum.map(&1, fn i -> String.to_integer(i) end))
  end

  def valid?(update, ruleset) do
    indexed =
      update
      |> Enum.with_index()
      |> Map.new()

    ruleset
    |> Stream.filter(fn {a, b} -> Map.has_key?(indexed, a) and Map.has_key?(indexed, b) end)
    |> Enum.all?(fn {a, b} -> indexed[a] < indexed[b] end)
  end

  def fix(update, ruleset) do
    indexed =
      update
      |> Enum.with_index()
      |> Map.new()

    {c1, c2} =
      ruleset
      |> Stream.filter(fn {a, b} -> Map.has_key?(indexed, a) and Map.has_key?(indexed, b) end)
      |> Enum.find({nil, nil}, fn {a, b} -> indexed[a] > indexed[b] end)

    fixed =
      update
      |> Enum.map(fn
        ^c1 -> c2
        ^c2 -> c1
        i -> i
      end)

    if valid?(fixed, ruleset) do
      fixed
    else
      fix(fixed, ruleset)
    end
  end

  #  def get_rules(ruleset, num), do: Enum.filter(ruleset, fn {a,b} -> a == num or b == num end)

  #  def valid?(update, ruleset) do
  #    item_count = length(update)
  #
  #    Enum.all?(update, fn value ->
  #      pos = Enum.find_index(update, &(&1 == value))
  #      head = if pos == 0 do [] else Enum.slice(update, 0..pos - 1) end
  #      tail = if pos == item_count - 1 do [] else Enum.slice(update, pos + 1..item_count) end
  #
  #      rules = get_rules(ruleset, value)
  #
  #      Enum.all?(rules, fn {rh, rt} ->
  #        if rh == value do
  #          # checking the rt in the head portion of the update, becasuse
  #          # if any number is in the head portion that have to be following
  #          # the value is wrong
  #          if length(head) == 0 do
  #            true
  #          else
  #            not Enum.any?(head, &(&1 == rt))
  #          end
  #
  #        else
  #          if length(tail) == 0 do
  #            true
  #          else
  #            not Enum.any?(tail, &(&1 == rh))
  #          end
  #        end
  #
  #      end)
  #    end)
  #  end

  def part1(updates, ruleset) do
    Enum.reduce(updates, 0, fn update, acc ->
      if valid?(update, ruleset) do
        pos = floor(length(update) / 2)
        acc + Enum.at(update, pos)
      else
        acc
      end
    end)
  end

  def part2(updates, ruleset) do
    Enum.reduce(updates, 0, fn update, acc ->
      if not valid?(update, ruleset) do
        fixed = fix(update, ruleset)
        pos = floor(length(fixed) / 2)
        acc + Enum.at(fixed, pos)
      else
        acc
      end
    end)
  end
end
