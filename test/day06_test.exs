defmodule Day06Test do
  use ExUnit.Case

  alias AoC.Day06, as: M

  # Guard is at the position 6,4
  @laboratory """
  ....#.....
  .........#
  ..........
  ..#.......
  .......#..
  ..........
  .#..^.....
  ........#.
  #.........
  ......#...
  """

  def process_input() do
    @laboratory
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  test "finding the guard position" do
    input = process_input()

    actual = M.find_guard(input)
    expected = {6, 4}

    assert actual == expected
  end

  test "get guards direction" do
    input = process_input()
    {x, y} = M.find_guard(input)
    guard = get_in(input, [Access.at(x), Access.at(y)])

    actual = M.direction(guard)
    expected = {-1, 0}

    assert actual == expected
  end

  test "rotate the guard" do
    assert M.turn_right("^") == ">"
    assert M.turn_right(">") == "v"
    assert M.turn_right("v") == "<"
    assert M.turn_right("<") == "^"
  end

  test "table indexing" do
    input = process_input()
    indexed = M.index_table(input)
    assert is_map(indexed)

    row = Map.get(indexed, 6)
    assert is_map(row)

    guard = Map.get(row, 4)
    assert guard == "^"
  end

  test "walk the guard through the table" do
    input = process_input()
    actual = M.part1(input)
    expected = 41

    assert actual == expected
  end
end
