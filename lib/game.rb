require './lib/ship'
require './lib/cell'
require './lib/board'


class Game

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def main_menu
    puts "-" * 50
    puts "Welcome to BATTLESHIP"
    puts "Enter P to play. Enter Q to quit."
    puts "-" * 50
    response = gets.chomp.upcase
    if response == "P"
      setup_computer
    elsif response == "Q"
      puts "Thank you for playing. Play agian later!"
    else
      puts "***Invalid response.*** Please select 'P' or 'Q'"
    end
  end

  def place_ship_computer(ship)
    coordinates = []
    coordinates = @computer_board.cells.keys.sample(ship.length)
    until @computer_board.valid_placement?(ship, coordinates)
      coordinates = @computer_board.cells.keys.sample(ship.length)
    end
    @computer_board.place(ship, coordinates)
  end

  def setup_computer
    place_ship_computer(@computer_cruiser)
    place_ship_computer(@computer_submarine)
    setup
  end

  def place_ship_player(ship)
    loop do
      cruiser_placement = gets.chomp.upcase.gsub(" ", ",").split(",")
      if @player_board.valid_placement?(ship, cruiser_placement)
        @player_board.place(@player_cruiser, cruiser_placement)
        puts @player_board.render(true)
    break
      elsif @player_board.valid_placement?(ship, cruiser_placement) == false
        puts "The coordinates you entered are invalid! Please try again."
      end
    end
  end

  def setup_player
    puts "Enter the coordinates for the Cruiser (3 spaces):"
    place_ship_player(@player_cruiser)
    puts "Enter the coordinates for the Submarine (2 spaces):"
    place_ship_player(@player_submarine)
    # setup
  end

  def setup
    puts "-" * 50
    puts "Your opponent has laid out its ships on the board."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "-" * 50
    puts @player_board.render(true)
    puts "-" * 50
    setup_player

  end

  #player needs a message to guide through set up process
  # player needs to interact with terminal to place the two ships
  #board needs to render true each time a ship is placed.
  # the player and computer will take turns shooting at the others boa


end
