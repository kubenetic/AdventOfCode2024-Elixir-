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

    current_row = get_in(table, [Access.key!(x)])

    next_field = get_in(table, [Access.key(next_x, nil), Access.key(next_y, nil)])

    cond do
      next_field == "#" ->
        rotated_guard = turn_right(guard)
        updated_row = Map.update!(current_row, y, fn _ -> rotated_guard end)
        updated_table = Map.update!(table, x, fn _ -> updated_row end)
        step(updated_table, x, y, acc)

      next_field == "." or next_field == "X" ->
        updated_current_row = Map.update!(current_row, y, fn _ -> "X" end)
        updated_table = Map.update!(table, x, fn _ -> updated_current_row end)

        next_row = get_in(updated_table, [Access.key!(next_x)])
        updated_next_row = Map.update!(next_row, next_y, fn _ -> guard end)

        updated_table = Map.update!(updated_table, next_x, fn _ -> updated_next_row end)

        steps = if next_field == "X" do acc else acc + 1 end

        step(updated_table, next_x, next_y, steps)

      true ->
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

  def walk(table) do
    {x, y} = find_guard(table)
    indexed_table = index_table(table)
    step(indexed_table, x, y, 0)
  end
end
