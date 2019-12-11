require_relative 'test_helper'
require_relative '../lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_its_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    assert_equal "Submarine", @submarine.name
    assert_equal 2, @submarine.length
    assert_equal 2, @submarine.health
  end

  def test_hit
    assert_equal 3, @cruiser.health
    @cruiser.hit
    assert_equal 2, @cruiser.health
    @cruiser.hit
    assert_equal 1, @cruiser.health
  end

  def test_sunk?
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
    refute @submarine.sunk?
    @submarine.hit
    @submarine.hit
    assert @submarine.sunk?
  end
end
