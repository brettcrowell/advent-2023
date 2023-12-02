defmodule Puzzle01 do
  @moduledoc """
  Documentation for `Advent2023`.
  """
  def sum_first_last(input) do
    matches = Regex.scan(~r/\d/, input)

    [first] = List.first(matches)
    [last] = List.last(matches)

    String.to_integer(first <> last)
  end

  def part1(input) do
    Enum.reduce(String.split(input, "\n"), 0, fn line, acc -> acc + sum_first_last(line) end)
  end
end
