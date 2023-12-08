defmodule Puzzle05 do
  def parse_seeds(input) do
    [[_, seeds]] = Regex.scan(~r/(?:seeds: )([\d\s]+)/, input)
    Regex.scan(~r/\d+/, seeds) |> List.flatten() |> Enum.map(&String.to_integer/1)
  end

  def parse_range(input) do
    [[_, destination_range_start, source_range_start, range_length]] =
      Regex.scan(~r/(\d+) (\d+) (\d+)/, input)

    %{
      :destination_range_start => destination_range_start |> String.to_integer(),
      :source_range_start => source_range_start |> String.to_integer(),
      :range_length => range_length |> String.to_integer()
    }
  end

  def parse_map(input) do
    [[_, source, destination, ranges]] = Regex.scan(~r/(\w+)-to-(\w+) map:\n([\d \n]+)/, input)

    %{
      :source => source,
      :destination => destination,
      :ranges =>
        ranges
        |> String.split("\n")
        |> Enum.filter(fn range -> range != "" end)
        |> Enum.map(&parse_range/1)
    }
  end

  def parse_input(input) do
    [[_, seeds, maps]] = Regex.scan(~r/(.*?)\n\n([\s\S]*)/, input)

    %{
      :seeds => parse_seeds(seeds),
      :maps =>
        Regex.scan(~r/.+ map:\n[\d \n]+/, maps)
        |> List.flatten()
        |> Enum.map(&parse_map/1)
    }
  end

  def solve_part_1 do
  end
end
