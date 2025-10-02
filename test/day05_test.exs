defmodule Day05Test do
  use ExUnit.Case

  alias AoC.Day05, as: M

  @ruleset [
    {47, 53},
    {97, 13},
    {97, 61},
    {97, 47},
    {75, 29},
    {61, 13},
    {75, 53},
    {29, 13},
    {97, 29},
    {53, 29},
    {61, 53},
    {97, 53},
    {61, 29},
    {47, 13},
    {75, 47},
    {97, 75},
    {47, 61},
    {75, 61},
    {47, 29},
    {75, 13},
    {53, 13}
  ]

  test "update [75,47,61,53,29] should be correct" do
    assert M.valid?([75, 47, 61, 53, 29], @ruleset)
  end

  test "update [97,61,53,29,13] should be correct" do
    assert M.valid?([97, 61, 53, 29, 13], @ruleset)
  end

  test "update [75,29,13] should be correct" do
    assert M.valid?([75, 29, 13], @ruleset)
  end

  test "update [75,97,47,61,53] should not be correct" do
    assert not M.valid?([75, 97, 47, 61, 53], @ruleset)
  end

  test "update [61,13,29] should not be correct" do
    assert not M.valid?([61, 13, 29], @ruleset)
  end

  test "update [97,13,75,29,47] should not be correct" do
    assert not M.valid?([97, 13, 75, 29, 47], @ruleset)
  end

  test "test with multiple updates" do
    updates = [
      [75, 47, 61, 53, 29],
      [97, 61, 53, 29, 13],
      [75, 29, 13],
      [75, 97, 47, 61, 53],
      [61, 13, 29],
      [97, 13, 75, 29, 47]
    ]

    actual = M.part1(updates, @ruleset)
    expected = 143

    assert actual == expected
  end

  test "try to fix the update [75, 97, 47, 61, 53]" do
    update = [75, 97, 47, 61, 53]
    fixed = M.fix(update, @ruleset)

    assert M.valid?(fixed, @ruleset)
  end

  test "try to fix the update [61, 13, 29]" do
    update = [61, 13, 29]
    fixed = M.fix(update, @ruleset)

    assert M.valid?(fixed, @ruleset)
  end

  test "try to fix the update [97, 13, 75, 29, 47]" do
    update = [97, 13, 75, 29, 47]
    fixed = M.fix(update, @ruleset)

    assert M.valid?(fixed, @ruleset)
  end

  test "test with multiple updates that need to be fixed" do
    updates = [
      [75, 97, 47, 61, 53],
      [61, 13, 29],
      [97, 13, 75, 29, 47]
    ]

    actual = M.part2(updates, @ruleset)
    expected = 123

    assert actual == expected
  end
end
