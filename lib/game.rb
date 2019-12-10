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

  def setup
    puts "-" * 50
    puts "Your opponent has laid out its ships on the board."
    puts
    puts "You now need to lay out your two ships."
    puts
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "-" * 50
    puts @player_board.render(true)
    puts "-" * 50
    setup_player
  end

  def setup_player
    puts "Enter the coordinates for the Cruiser (3 coordinates seperated by a space or a comma):"
    place_ship_player(@player_cruiser)
    puts "Enter the coordinates for the Submarine (2 coordinates seperated by a space or a comma):"
    place_ship_player(@player_submarine)
    puts "-" * 50
    puts "Setup complete. Play Battleship!!"
    puts "-" * 50
    take_turn
  end

  def place_ship_player(ship)
    loop do
      ship_placement = gets.chomp.upcase.gsub(" ", ",").split(",")
      if @player_board.valid_placement?(ship, ship_placement)
        @player_board.place(@player_cruiser, ship_placement)
        puts @player_board.render(true)
        break
      elsif @player_board.valid_placement?(ship, ship_placement) == false
        puts "The coordinates you entered are invalid! Please try again."
      end
    end
  end

  def take_turn
    until @player_cruiser.sunk? && @player_submarine.sunk? == true || @computer_cruiser.sunk? && @computer_submarine.sunk? == true
      display_boards
      player_shoot
      computer_shoot
      display_player_results
      display_computer_results
    end
    game_over
    initialize
    main_menu
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_shoot
    loop do
       puts "Enter the coordinates you want to fire upon!"
       @player_shot = gets.chomp.upcase.gsub(" ", "")
      if @computer_board.valid_coordinate?(@player_shot) == true && @computer_board.cells[@player_shot].fired_upon? == false
        @computer_board.cells[@player_shot].fire_upon
        break
      elsif @computer_board.valid_coordinate?(@player_shot) == true && @computer_board.cells[@player_shot].fired_upon? == true
        puts "You have already fired upon this coordinate. Try again."
      else
        puts "Invalid input. Please enter a valid coordinate."
      end
    end
  end

  def computer_shoot
    @computer_shot = @player_board.cells.keys.sample
    if @player_board.cells[@computer_shot].fired_upon? == false
       # @player_board.valid_coordinate?(@computer_shot)
      @player_board.cells[@computer_shot].fire_upon
    elsif
      @computer_shot = @player_board.cells.keys.sample
    end
  end

  def display_player_results
    if @computer_board.cells[@player_shot].render == "M"
      puts "Your shot was a Miss"
      puts "-" * 50
    elsif @computer_board.cells[@player_shot].render == "H"
      puts "Your shot was a Hit"
      puts "-" * 50
    elsif @computer_board.cells[@player_shot].render == "X"
      puts "You sunk the computers ship"
      puts "-" * 50
    end
  end

  def display_computer_results
    if @player_board.cells[@computer_shot].render == "M"
      puts "The computers shot was a Miss"
    elsif @player_board.cells[@computer_shot].render == "H"
      puts "The computers shot was a Hit"
    elsif @player_board.cells[@computer_shot].render == "X"
      puts "The computer sunk your ship"
    end
  end

  def game_over
    if @player_cruiser.sunk? && @player_submarine.sunk? == true
      puts "The computer wins!"
    elsif @computer_cruiser.sunk? && @computer_submarine.sunk? == true
      puts "You Win!"
    end
  end
end
