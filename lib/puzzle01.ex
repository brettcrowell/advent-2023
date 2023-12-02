defmodule Puzzle01 do
  @moduledoc """
  Documentation for `Advent2023`.
  """

  def to_integer(number) do
    case number do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
      _ -> number
    end
  end

  def sum_first_last(input) do
    matches =
      Regex.scan(
        ~r/(\d|(?=((one)))|(?=(two))|(?=(three))|(?=(four))|(?=(five))|(?=(six))|(?=(seven))|(?=(eight))|(?=(nine)))/,
        input
      )

    first = List.last(List.first(matches))
    last = List.last(List.last(matches))

    String.to_integer(to_integer(first) <> to_integer(last))
  end

  def part1(input) do
    Enum.reduce(String.split(input, "\n"), 0, fn line, acc -> acc + sum_first_last(line) end)
  end
end
