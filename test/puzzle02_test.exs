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

  describe "solve_part_1" do
    test "should sum the ids of the possible games" do
      input = """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

      assert 8 == Puzzle02.solve_part_1(input)
    end
  end

  describe "minimize_cubes" do
    test "should return the minimum number of cubes of each color" do
      game_1 = Puzzle02.parse_game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
      assert %{:min_red => 4, :min_green => 2, :min_blue => 6} == Puzzle02.minimize_cubes(game_1)

      game_2 =
        Puzzle02.parse_game("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue")

      assert %{:min_red => 1, :min_green => 3, :min_blue => 4} == Puzzle02.minimize_cubes(game_2)

      game_3 =
        Puzzle02.parse_game(
          "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
        )

      assert %{:min_red => 20, :min_green => 13, :min_blue => 6} ==
               Puzzle02.minimize_cubes(game_3)

      game_4 =
        Puzzle02.parse_game(
          "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
        )

      assert %{:min_red => 14, :min_green => 3, :min_blue => 15} ==
               Puzzle02.minimize_cubes(game_4)

      game_5 =
        Puzzle02.parse_game("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green")

      assert %{:min_red => 6, :min_green => 3, :min_blue => 2} ==
               Puzzle02.minimize_cubes(game_5)
    end
  end

  describe "compute_power" do
    test "multiplies the colors" do
      assert 48 == Puzzle02.compute_power(%{:min_red => 4, :min_green => 2, :min_blue => 6})

      assert 12 == Puzzle02.compute_power(%{:min_red => 1, :min_green => 3, :min_blue => 4})

      assert 1560 == Puzzle02.compute_power(%{:min_red => 20, :min_green => 13, :min_blue => 6})

      assert 630 == Puzzle02.compute_power(%{:min_red => 14, :min_green => 3, :min_blue => 15})

      assert 36 == Puzzle02.compute_power(%{:min_red => 6, :min_green => 3, :min_blue => 2})
    end
  end

  describe "solve_part_2" do
    test "should compute the fewest number of cubes to make a game possible" do
      input = """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """

      assert 2286 == Puzzle02.solve_part_2(input)
    end
  end
end
