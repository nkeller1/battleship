require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_cells_hash_exists
    assert_instance_of Hash, @board.cells
  end

  def test_hash_contains_correct_number_of_keys_and_values
    assert_equal 16, @board.cells.keys.count
    assert_equal 16, @board.cells.values.count
  end

  def test_hash_values_are_cell_objects
    assert_instance_of Cell, @board.cells.values.first
  end

  def test_valid_coordinate?
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
    assert_equal false, @board.valid_coordinate?(00)
    assert_equal false, @board.valid_coordinate?(:A1)
  end

  def test_that_coordinate_length_is_valid_based_on_ship_length
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
  end

  def test_valid_grid_allignment?
    expected = {letters: [65, 65, 65], numbers: [1, 2, 3]}
    expected_2 = {letters: [65, 66, 67], numbers: [1, 1, 1]}
    assert_equal expected, @board.valid_grid_allignment?(["A1", "A2", "A3"])
    assert_equal expected_2, @board.valid_grid_allignment?(["A1", "B1", "C1"])
  end

  def test_consecutive_ship_placement
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal true, @board.valid_placement?(@submarine, ["C1", "B1"])
  end

  def test_other_cases_of_valid_placement?
    #vertical ship placment
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "B1", "C1"])
    #diagonal ship placement
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
  end

  def test_place_ship_on_board
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
    assert_equal true, cell_2.ship == cell_1.ship
  end

  def test_ship_overlap?
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["A1", "B1"])
    assert_equal true, @board.ship_overlap?(["D1", "D2"])
    assert_equal false, @board.ship_overlap?(["A1", "B1"])
  end

  def test_ship_overlap_within_valid_palcement?
    @board.place(@cruiser, ["A1", "A2", "A3"])
    @board.place(@submarine, ["A1", "B1"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_board_render_method
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expected_computer_board = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
      expected_player_board = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
      assert_equal expected_computer_board, @board.render
      assert_equal expected_player_board, @board.render(true)

      board_with_miss = "  1 2 3 4 \nA S S S . \nB M . . . \nC . . . . \nD . . . . \n"
      @board.cells["B1"].fire_upon
      assert_equal board_with_miss, @board.render(true)

      board_with_hit = "  1 2 3 4 \nA H S S . \nB M . . . \nC . . . . \nD . . . . \n"
      @board.cells["A1"].fire_upon
      assert_equal board_with_hit, @board.render(true)

      board_with_sunk = "  1 2 3 4 \nA X X X . \nB M . . . \nC . . . . \nD . . . . \n"
      @board.cells["A2"].fire_upon
      @board.cells["A3"].fire_upon
      assert_equal board_with_sunk, @board.render(true)
  end

end
