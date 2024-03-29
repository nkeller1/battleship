require_relative 'test_helper'
require_relative '../lib/ship'
require_relative '../lib/cell'

class CellTest < Minitest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_its_attributes
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
  end

  def test_if_cell_is_empty
    assert_equal true, @cell.empty?
  end

  def test_place_ship_in_cell
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_fire_upon_and_fired_upon?
    @cell.place_ship(@cruiser)
    refute @cell.fired_upon?
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
    @cell.fire_upon
    assert_equal 1, @cell.ship.health
  end


  def test_cell_renders_correctly
    assert_equal ".", @cell.render
    @cell.fire_upon
    assert_equal "M", @cell.render
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
