defmodule Puzzle04Test do
  use ExUnit.Case

  describe "compute score" do
    test "should return 0 for empty lists" do
      assert 0 == Puzzle04.compute_score([])
    end

    test "should return 1 for single-item lists" do
      assert 1 == Puzzle04.compute_score([1])
    end

    test "should double scores after the first" do
      assert 2 == Puzzle04.compute_score([1, 1])
      assert 8 == Puzzle04.compute_score([1, 1, 1, 1])
    end
  end

  describe "parse_card" do
    test "should convert a card into a struct" do
      assert %{
               :card => 1,
               :winners => [41, 48, 83, 86, 17],
               :draws => [83, 86, 6, 31, 17, 9, 48, 53]
             } == Puzzle04.parse_card("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")

      assert %{
               :card => 4,
               :winners => [41, 92, 73, 84, 69],
               :draws => [59, 84, 76, 51, 58, 5, 54, 83]
             } == Puzzle04.parse_card("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83")
    end
  end

  describe "solve_part_1" do
    input = """
    Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
    Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
    Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
    Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
    Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
    Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
    """

    assert 13 == Puzzle04.solve_part_1(input)
  end

  describe "get_matching_cards" do
    test "should return the card if there are no winners" do
      card = Puzzle04.parse_card("Card 1: 1 | 2")
      assert [card] == Puzzle04.get_matching_cards(card, [card])
    end

    test "should return the next card if there is one winner" do
      card_1 = Puzzle04.parse_card("Card 1: 1 | 1")
      card_2 = Puzzle04.parse_card("Card 2: 1 | 2")

      assert [card_1, card_2] == Puzzle04.get_matching_cards(card_1, [card_1, card_2])
    end

    test "should return the next two cards if there are two winners" do
      card_1 = Puzzle04.parse_card("Card 1: 1 | 1")
      card_2 = Puzzle04.parse_card("Card 2: 1 | 1")
      card_3 = Puzzle04.parse_card("Card 3: 1 | 2")

      assert [card_1, card_2, card_3] ==
               Puzzle04.get_matching_cards(card_1, [card_1, card_2, card_3])
    end
  end

  describe "solve_part_2" do
    test "should return the number of cards" do
      input = """
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      """

      assert 30 == Puzzle04.solve_part_2(input)
    end
  end
end
