defmodule Puzzle01Test do
  use ExUnit.Case

  describe "#sum_first_last" do
    test "should sum the first and last digits found in a string" do
      assert 12 == Puzzle01.sum_first_last("1abc2")
      assert 38 == Puzzle01.sum_first_last("pqr3stu8vwx")
      assert 15 == Puzzle01.sum_first_last("a1b2c3d4e5f")
      assert 77 == Puzzle01.sum_first_last("treb7uchet")
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
  end
end
