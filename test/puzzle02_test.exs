defmodule Puzzle02Test do
  use ExUnit.Case

  describe "parse_set" do
    test "should split sets into structs" do
      assert %{"blue" => 3, "red" => 4, "green" => 0} == Puzzle02.parse_set("3 blue, 4 red")
    end
  end

  describe "parse_game" do
    @game "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

    test "should parse the game id" do
      assert 1 == Puzzle02.parse_game(@game)[:id]
    end

    test "should return the sets" do
      assert [
               %{"blue" => 3, "red" => 4, "green" => 0},
               %{"blue" => 6, "red" => 1, "green" => 2},
               %{"blue" => 0, "red" => 0, "green" => 2}
             ] == Puzzle02.parse_game(@game)[:sets]
    end
  end

  describe "solve" do
    test "should sum the ids of the possible games" do
      input = """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

      assert 8 == Puzzle02.solve(input)
    end
  end
end
