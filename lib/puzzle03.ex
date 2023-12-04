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
    tokens =
      String.split(input, "\n") |> Enum.with_index() |> Enum.map(&get_tokens/1) |> List.flatten()

    symbols = Enum.filter(tokens, fn %{is_symbol: is_symbol} -> is_symbol end)
    parts = Enum.filter(tokens, fn %{is_symbol: is_symbol} -> !is_symbol end)

    Enum.filter(parts, &has_adjacent_symbol(&1, symbols))
    |> Enum.map(fn %{token: token} -> String.to_integer(token) end)
    |> Enum.sum()
  end
end
