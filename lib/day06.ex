defmodule AoC.Day06 do
  @guard "^"

  def input(fname) do
    File.stream!(fname)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(&1 == ""))
    |> Stream.map(&String.split(&1, "", trim: true))
  end

  def direction("^"), do: {-1, 0}
  def direction(">"), do: {0, 1}
  def direction("v"), do: {1, 0}
  def direction("<"), do: {0, -1}

  def turn_right("^"), do: ">"
  def turn_right(">"), do: "v"
  def turn_right("v"), do: "<"
  def turn_right("<"), do: "^"

  def step(table, x, y, acc) do
    guard = get_in(table, [Access.key!(x), Access.key!(y)])

    {mov_x, mov_y} = direction(guard)
    {next_x, next_y} = {x + mov_x, y + mov_y}

    next_field = get_in(table, [Access.key(next_x, %{}), Access.key(next_y, %{})])
    case next_field do
      "#" ->
        table
        |> put_in([Access.key!(x), Access.key!(y)], turn_right(guard))
        |> step(x, y, acc)

      "." ->
        table
        |> put_in([Access.key!(x), Access.key!(y)], "X")
        |> put_in([Access.key!(next_x), Access.key!(next_y)], guard)
        |> step(next_x, next_y, acc + 1)

      "X" ->
        table
        |> put_in([Access.key!(x), Access.key!(y)], "X")
        |> put_in([Access.key!(next_x), Access.key!(next_y)], guard)
        |> step(next_x, next_y, acc)

      %{} ->
        acc + 1
    end
  end

  def find_guard(table) do
    x = Enum.find_index(table, &Enum.member?(&1, @guard))
    y = Enum.at(table, x) |> Enum.find_index(&(&1 == @guard))

    {x, y}
  end

  def index_table(table) do
    table
    |> Stream.map(fn row ->
      Enum.with_index(row) |> Map.new(fn {field, idx} -> {idx, field} end)
    end)
    |> Stream.with_index()
    |> Map.new(fn {row, idx} -> {idx, row} end)
  end

  def part1(table) do
    {x, y} = find_guard(table)
    indexed_table = index_table(table)
    step(indexed_table, x, y, 0)
  end
end
