defmodule Puzzle03 do
  def get_tokens({row, row_number}) do
    Regex.scan(~r/\d+|[^A-Za-z0-9.]/, row, return: :index)
    |> Enum.map(fn [{start, length}] ->
      token = String.slice(row, start, length)

      %{
        :token => token,
        :x => start,
        :y => row_number,
        :length => length,
        :is_symbol => Regex.match?(~r/[^A-Za-z0-9.]/, token)
      }
    end)
  end

  def parse_tokens(input) do
    String.split(input, "\n") |> Enum.with_index() |> Enum.map(&get_tokens/1) |> List.flatten()
  end

  def get_all_points(%{x: x, y: y, length: length}) do
    for c <- 0..(length - 1), do: {x + c, y}
  end

  def distance({from_x, from_y}, {to_x, to_y}) do
    abs(:math.sqrt((from_x - to_x) ** 2 + (from_y - to_y) ** 2))
  end

  def has_adjacent_symbol(part, symbols) do
    Enum.any?(get_all_points(part), fn point ->
      Enum.any?(symbols, fn symbol -> distance(point, {symbol.x, symbol.y}) < 2 end)
    end)
  end

  def solve_part_1(input) do
    tokens = parse_tokens(input)

    symbols = Enum.filter(tokens, fn %{is_symbol: is_symbol} -> is_symbol end)
    parts = Enum.filter(tokens, fn %{is_symbol: is_symbol} -> !is_symbol end)

    Enum.filter(parts, &has_adjacent_symbol(&1, symbols))
    |> Enum.map(fn %{token: token} -> String.to_integer(token) end)
    |> Enum.sum()
  end

  def get_adjacent_parts(symbol, parts) do
    Enum.filter(parts, fn part ->
      Enum.any?(get_all_points(part), fn point ->
        distance(point, {symbol.x, symbol.y}) < 2
      end)
    end)
  end

  def compute_ratio([%{token: gear_1}, %{token: gear_2}]) do
    String.to_integer(gear_1) * String.to_integer(gear_2)
  end

  def solve_part_2(input) do
    tokens = parse_tokens(input)

    gears = Enum.filter(tokens, fn %{token: token} -> token == "*" end)
    parts = Enum.filter(tokens, fn %{is_symbol: is_symbol} -> !is_symbol end)

    gears
    |> Enum.map(&get_adjacent_parts(&1, parts))
    |> Enum.filter(fn parts -> length(parts) == 2 end)
    |> Enum.map(&compute_ratio/1)
    |> Enum.sum()
  end
end
