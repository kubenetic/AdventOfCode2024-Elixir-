defmodule AoC.Day02Test do
  use ExUnit.Case

  alias AoC.Day02, as: M

  test "report should be safe because the levels are all decreasing by 1 or 2" do
    assert M.safe?([7, 6, 4, 2, 1])
  end

  test "report should be unsafe because 2 7 is an increase of 5" do
    assert not M.safe_with_dampener?([1, 2, 7, 8, 9])
  end

  test "report should be unsafe because 6 2 is a decrease of 4" do
    assert not M.safe_with_dampener?([9, 7, 6, 2, 1])
  end

  test "report should be safe because 1 3 is increasing but 3 2 is decreasing but it is tolerable" do
    assert M.safe_with_dampener?([1, 3, 2, 4, 5])
  end

  test "report should be safe because 4 4 is neither an increase or a decrease but it is tolerable" do
    assert M.safe_with_dampener?([8, 6, 4, 4, 1])
  end

  test "report should be safe because the levels are all decreasing by 1, 2 or 3" do
    assert M.safe?([1, 3, 6, 7, 9])
  end

  test "report should be unsafe because it changes direction two times" do
    assert not M.safe_with_dampener?([2, 4, 1, 4, 3])
  end

  test "report should be safe because event it's change direction it is tolerable" do
    assert M.safe_with_dampener?([54, 52, 53, 56, 57, 58])
  end

end
