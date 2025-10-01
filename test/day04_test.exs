defmodule Day04Test do
  use ExUnit.Case

  alias AoC.Day04, as: M

  @test_input """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  def get_input() do
    @test_input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  test "retrieve full main axis" do
    actual = get_input() |> M.axis(0, 0, :main)
    expected = "MSXMAXSAMX"

    assert actual == expected
  end

  test "retrieve main parallel axis" do
    actual = get_input() |> M.axis(2, 0, :main)
    expected = "ASAMSAMA"

    assert actual == expected
  end

  test "retrieve full secondary axis" do
    actual = get_input() |> M.axis(0, 9, :secondary)
    expected = "MSAMMMMXAM"

    assert actual == expected
  end
end
