require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists

    assert_instance_of Cell, @cell

  end

  def test_coordinate

    assert_equal "B4", @cell.coordinate

  end

  def test_ship

    assert_nil @cell.ship

  end

  # def test_if_cell_is_empty
  #
  #   assert_equal true, @cell.empty?
  #
  # end
  #
  # def test_cruiser_exists
  #
  #   assert_equal @cruiser, Ship.new("Cruiser")
  #
  # end

end
