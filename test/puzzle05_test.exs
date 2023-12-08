defmodule Puzzle05Test do
  use ExUnit.Case

  describe "parse_seeds" do
    test "should return a list of seed numbers" do
      assert [79, 14, 55, 13] == Puzzle05.parse_seeds("seeds: 79 14 55 13")
    end
  end

  describe "parse_range" do
    test "should return a valid range" do
      assert %{:destination_range_start => 50, :source_range_start => 98, :range_length => 2} =
               Puzzle05.parse_range("50 98 2")
    end
  end

  describe "parse_map" do
    test "should return a valid map" do
      input = """
      seed-to-soil map:
      50 98 2
      52 50 48
      """

      assert %{
               :source => "seed",
               :destination => "soil",
               :ranges => [
                 %{:destination_range_start => 50, :source_range_start => 98, :range_length => 2},
                 %{:destination_range_start => 52, :source_range_start => 50, :range_length => 48}
               ]
             } == Puzzle05.parse_map(input)
    end
  end

  describe "parse_input" do
    test "should return seeds and all maps" do
      input = """
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15
      """

      assert %{
               :seeds => [79, 14, 55, 13],
               :maps => [
                 %{
                   :source => "seed",
                   :destination => "soil",
                   :ranges => [
                     %{
                       :destination_range_start => 50,
                       :source_range_start => 98,
                       :range_length => 2
                     },
                     %{
                       :destination_range_start => 52,
                       :source_range_start => 50,
                       :range_length => 48
                     }
                   ]
                 },
                 %{
                   :source => "soil",
                   :destination => "fertilizer",
                   :ranges => [
                     %{
                       :destination_range_start => 0,
                       :source_range_start => 15,
                       :range_length => 37
                     },
                     %{
                       :destination_range_start => 37,
                       :source_range_start => 52,
                       :range_length => 2
                     },
                     %{
                       :destination_range_start => 39,
                       :source_range_start => 0,
                       :range_length => 15
                     }
                   ]
                 }
               ]
             } == Puzzle05.parse_input(input)
    end
  end
end
