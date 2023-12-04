defmodule Puzzle03Test do
  use ExUnit.Case

  describe "get_tokens" do
    test "should return tokens with their x coordinates" do
      assert [
               %{token: "467", x: 0, y: 0, length: 3},
               %{token: "114", x: 5, y: 0, length: 3}
             ] = Puzzle03.get_tokens({"467..114..", 0})

      assert [
               %{token: "*", x: 3, y: 1, length: 1}
             ] = Puzzle03.get_tokens({"...*......", 1})

      assert [
               %{token: "35", x: 2, y: 2, length: 2},
               %{token: "633", x: 6, y: 2, length: 3}
             ] = Puzzle03.get_tokens({"..35..633.", 2})

      assert [
               %{token: "#", x: 6, y: 3, length: 1}
             ] = Puzzle03.get_tokens({"......#...", 3})

      assert [
               %{token: "617", x: 0, y: 4, length: 3},
               %{token: "*", x: 3, y: 4, length: 1}
             ] = Puzzle03.get_tokens({"617*......", 4})
    end
  end

  describe "get_all_points" do
    test "should generate a list of points in the token" do
      assert [{0, 4}, {1, 4}, {2, 4}] =
               Puzzle03.get_all_points(%{token: "617", x: 0, y: 4, length: 3})

      assert [{3, 4}] = Puzzle03.get_all_points(%{token: "*", x: 3, y: 4, length: 1})
    end
  end

  describe "has_adjacent_symbol" do
    assert true ==
             Puzzle03.has_adjacent_symbol(
               %{x: 0, y: 0, length: 1},
               [%{x: 0, y: 0}]
             )

    assert true ==
             Puzzle03.has_adjacent_symbol(
               %{x: 0, y: 0, length: 1},
               [%{x: 1, y: 0}]
             )

    assert false ==
             Puzzle03.has_adjacent_symbol(
               %{x: 0, y: 0, length: 1},
               [%{x: 2, y: 0}]
             )

    assert false ==
             Puzzle03.has_adjacent_symbol(
               %{x: 0, y: 0, length: 1},
               [%{x: 3, y: 0}]
             )
  end

  describe "solve_part_1" do
    test "should parse the tokens" do
      input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      assert 4361 == Puzzle03.solve_part_1(input)
    end
  end

  describe "get_adjacent_parts" do
    test "returns the number of parts adjacent to a symbol" do
      assert 2 ==
               length(
                 Puzzle03.get_adjacent_parts(
                   %{x: 3, y: 1, length: 1},
                   [
                     %{token: "467", x: 0, y: 0, length: 3},
                     %{token: "114", x: 5, y: 0, length: 3},
                     %{token: "35", x: 2, y: 1, length: 2},
                     %{token: "633", x: 6, y: 1, length: 3}
                   ]
                 )
               )
    end
  end

  describe "solve_part_2" do
    test "should parse the tokens" do
      input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """

      assert 467_835 == Puzzle03.solve_part_2(input)
    end
  end
end
