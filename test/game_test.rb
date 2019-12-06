require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'


class GameTest < Minitest::Test

  def setup
  @game = Game.new

  end

  def test_game_class_exists
  assert_instance_of Game, @game
  end

end
