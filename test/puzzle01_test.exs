defmodule Puzzle01Test do
  use ExUnit.Case

  describe "#sum_first_last" do
    test "should sum the first and last digits found in a string" do
      assert 12 == Puzzle01.sum_first_last("1abc2")
      assert 38 == Puzzle01.sum_first_last("pqr3stu8vwx")
      assert 15 == Puzzle01.sum_first_last("a1b2c3d4e5f")
      assert 77 == Puzzle01.sum_first_last("treb7uchet")
    end

    test "should understand written integers" do
      assert 29 == Puzzle01.sum_first_last("two1nine")
      assert 83 == Puzzle01.sum_first_last("eightwothree")
      assert 13 == Puzzle01.sum_first_last("abcone2threexyz")
      assert 24 == Puzzle01.sum_first_last("xtwone3four")
      assert 42 == Puzzle01.sum_first_last("4nineeightseven2")
      assert 14 == Puzzle01.sum_first_last("zoneight234")
      assert 76 == Puzzle01.sum_first_last("7pqrstsixteen")
    end
  end

  describe "#part1" do
    test "should return the total sum of all line sums" do
      input = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

      assert 142 == Puzzle01.part1(input)
    end

    test "should handle written numbers" do
      input = "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"

      assert 281 == Puzzle01.part1(input)
    end
  end
end
