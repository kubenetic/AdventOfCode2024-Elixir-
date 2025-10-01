defmodule AoC.Day04 do
  @pattern ~r/XMAS/

  def input(fname) do
    File.stream!(fname)
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  def walk(_, _, c, _, acc) when c < 0 do
    acc |> Enum.reverse() |> IO.iodata_to_binary()
  end

  def walk(data, r, c, step, acc) do
    case get_in(data, [Access.at(r), Access.at(c)]) do
      nil -> acc |> Enum.reverse() |> IO.iodata_to_binary()
      val -> walk(data, r + 1, c + step, step, [to_string(val) | acc])
    end
  end

  def axis(data, r, c, direction) when direction in [:main, :secondary] do
    step = if direction == :main, do: 1, else: -1
    walk(data, r, c, step, [])
  end

  def scan(line) do
    s = Enum.join(line, "")
    count_fw = Regex.scan(@pattern, s, capture: :all) |> Enum.count()
    count_bw = Regex.scan(@pattern, String.reverse(s), capture: :all) |> Enum.count()

    count_fw + count_bw
  end

  def process(data) do
    count_in_rows =
      Enum.reduce(data, 0, fn line, acc ->
        acc + scan(line)
      end)

    count_in_columns =
      Enum.zip(data)
      |> Enum.reduce(0, fn line, acc ->
        acc + scan(line)
      end)

    count_in_rows + count_in_columns
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
