defmodule AoC.Day03Test do
  use ExUnit.Case

  alias AoC.Day03, as: M

  test "handle instructions while parse don't()s and do()s" do
    input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

    expected = 48
    actual = M.part2(input)

    assert expected == actual
  end

end
