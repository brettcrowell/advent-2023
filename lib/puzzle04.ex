defmodule Puzzle04 do
  def parse_series(series) do
    Regex.scan(~r/\d+/, series) |> List.flatten() |> Enum.map(&String.to_integer/1)
  end

  def parse_card(card) do
    [[_, card_number, numbers]] = Regex.scan(~r/(\d+):(.*)/, card)
    [winning_series, draw_series] = String.split(numbers, "|")

    winners = parse_series(winning_series)
    draws = parse_series(draw_series)

    %{:card => String.to_integer(card_number), :winners => winners, :draws => draws}
  end

  def compute_score(numbers) do
    Enum.reduce(numbers, 0, fn _, acc ->
      case acc do
        0 -> 1
        _ -> acc * 2
      end
    end)
  end

  def is_winner(number, winning_numbers) do
    Enum.member?(winning_numbers, number)
  end

  def get_winners(%{winners: winners, draws: draws}) do
    Enum.filter(draws, &is_winner(&1, winners))
  end

  def solve_part_1(input) do
    input
    |> String.split("\n")
    |> Enum.filter(fn line -> line != "" end)
    |> Enum.map(&parse_card/1)
    |> Enum.map(&get_winners/1)
    |> Enum.map(&compute_score/1)
    |> Enum.sum()
  end
end
