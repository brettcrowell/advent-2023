defmodule Puzzle02 do
  def parse_set(set) do
    String.split(set, ",")
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(
      %{"red" => 0, "green" => 0, "blue" => 0},
      fn set, acc ->
        [[_, count, color]] = Regex.scan(~r/(\d+) (red|blue|green)/, set)
        %{acc | color => String.to_integer(count)}
      end
    )
  end

  def parse_game(game) do
    [[_, id, sets]] = Regex.scan(~r/Game (\d+):\s(.+)/, game)

    parsed_game = %{
      :id => String.to_integer(id),
      :sets =>
        String.split(sets, ";")
        |> Enum.map(&String.trim/1)
        |> Enum.map(&parse_set/1)
    }

    parsed_game
  end

  def is_possible(%{sets: sets}, max_red, max_green, max_blue) do
    Enum.any?(sets, fn %{"red" => red, "green" => green, "blue" => blue} ->
      red > max_red || green > max_green || blue > max_blue
    end)
  end

  def solve_part_1(input, max_red \\ 12, max_green \\ 13, max_blue \\ 14) do
    String.split(input, "\n")
    |> Enum.filter(fn game -> game != "" end)
    |> Enum.map(&parse_game/1)
    |> Enum.reduce(0, fn %{id: id} = game, acc ->
      if is_possible(game, max_red, max_green, max_blue) do
        acc
      else
        acc + id
      end
    end)
  end

  def minimize_cubes(%{sets: sets}) do
    base = %{:min_red => 0, :min_green => 0, :min_blue => 0}

    Enum.reduce(sets, base, fn %{
                                 "red" => red,
                                 "green" => green,
                                 "blue" => blue
                               },
                               acc ->
      %{
        acc
        | :min_red => Enum.max([acc[:min_red], red]),
          :min_green => Enum.max([acc[:min_green], green]),
          :min_blue => Enum.max([acc[:min_blue], blue])
      }
    end)
  end

  def compute_power(%{min_red: red, min_green: green, min_blue: blue}) do
    red * green * blue
  end

  def solve_part_2(input) do
    String.split(input, "\n")
    |> Enum.filter(fn game -> game != "" end)
    |> Enum.map(&parse_game/1)
    |> Enum.map(&minimize_cubes/1)
    |> Enum.map(&compute_power/1)
    |> Enum.sum()
  end
end
