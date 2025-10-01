defmodule AoC.Day01Test do
  use ExUnit.Case

  alias AoC.Day01 , as: M

  test "list must have the same length" do
    lst1 = [1,2,3]
    lst2 = [1,2,3,4]

    assert_raise(ArgumentError, fn ->
      M.calculate_distance(lst1, lst2)
    end)
  end

  test "distance calculation" do
    lst1 = [3, 4, 2, 1, 3, 3]
    lst2 = [4, 3, 5, 3, 9, 3]
    expected = 11

    current = M.calculate_distance(lst1, lst2)

    assert expected == current
  end

  test "similarity score calculation" do
    lst1 = [3, 4, 2, 1, 3, 3]
    lst2 = [4, 3, 5, 3, 9, 3]
    expected = 31

    current = M.calculate_similarity_score(lst1, lst2)

    assert expected == current
  end
end
