defmodule AoC.Day04 do
  @pattern ~r/XMAS/

  def input(fname) do
    File.stream!(fname)
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  def walk(_, r, c, _, acc) when r < 0 or c < 0, do: acc |> Enum.reverse()

  def walk(data, r, c, step, acc) do
    case get_in(data, [Access.at(r), Access.at(c)]) do
      nil -> acc |> Enum.reverse()
      val -> walk(data, r + 1, c + step, step, [val | acc])
    end
  end

  #  def axis(data, r, c, direction) when direction in [:main, :secondary] do
  #    step = if direction == :main, do: 1, else: -1
  #    walk(data, r, c, step, [])
  #  end

  def axis(data, r, c, :main), do: walk(data, r, c, 1, [])
  def axis(data, r, c, :secondary), do: walk(data, r, c, -1, [])

  def scan(line) when length(line) >= 4 do
    s = Enum.join(line, "")
    count_fw = Regex.scan(@pattern, s, capture: :all) |> Enum.count()
    count_bw = Regex.scan(@pattern, String.reverse(s), capture: :all) |> Enum.count()

    count_fw + count_bw
  end

  def scan(_), do: 0

  def part1(data) do
    rows = data |> length()
    cols = data |> hd() |> length()

    # count XMAS and its reverse in lines
    mc = data |> Enum.reduce(0, fn row, acc -> acc + scan(row) end)

    # count XMAS and its reverse in columns
    sc =
      data
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.reduce(0, fn col, acc -> acc + scan(col) end)

    # count XMAS and its reverse in diagonals
    # main diagonal axis TL -> BR
    mdc =
      for i <- 0..(rows - 1), reduce: 0 do
        acc -> acc + scan(axis(data, i, 0, :main))
      end +
        for i <- 1..(cols - 1), reduce: 0 do
          acc -> acc + scan(axis(data, 0, i, :main))
        end

    sdc =
      for i <- 0..(cols - 1), reduce: 0 do
        acc -> acc + scan(axis(data, 0, i, :secondary))
      end +
        for i <- 1..(rows - 1), reduce: 0 do
          acc -> acc + scan(axis(data, i, cols - 1, :secondary))
        end

    mc + sc + mdc + sdc
  end

  def part2(data) do
    rows = data |> length()
    cols = data |> hd() |> length()

    pattern = ~r/(MAS)|(SAM)/
    get = fn r, c -> get_in(data, [Access.at(r), Access.at(c)]) end


    for r <- 1..(rows - 2), c <- 1..(cols - 2), reduce: 0 do
      acc ->
        ce = get.(r, c)
        tl = get.(r - 1, c - 1)
        bl = get.(r + 1, c - 1)
        tr = get.(r - 1, c + 1)
        br = get.(r + 1, c + 1)

        dm = "#{tl}#{ce}#{br}"
        ds = "#{tr}#{ce}#{bl}"

        if Regex.match?(pattern, dm) and Regex.match?(pattern, ds) do
          acc + 1
        else
          acc
        end
    end
  end

  #  def axis(data, r, c, :main, acc) do
  #    case get_in(data, [Access.at(r), Access.at(c)]) do
  #      nil -> acc
  #      val -> axis(data, r + 1, c + 1, :main, "#{acc}#{val}")
  #    end
  #  end
  #
  #  def axis(data, r, c, :secondary, acc) do
  #    case get_in(data, [Access.at(r), Access.at(c)]) do
  #      nil -> acc
  #      val -> axis(data, r + 1, c - 1, :secondary, "#{acc}#{val}")
  #    end
  #  end

  #  def diag(data, row_idx, col_idx, acc) do
  #    row = Enum.at(data, row_idx)
  #
  #    if not is_nil(row) do
  #      val = Enum.at(row, col_idx)
  #
  #      if is_nil(val) do
  #        acc
  #      else
  #        diag(data, row_idx + 1, col_idx + 1, "#{acc}#{val}")
  #      end
  #    else
  #      acc
  #    end
  #  end
end
