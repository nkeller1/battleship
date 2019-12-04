class Board
  attr_reader :cells

  def initialize
    @cells = { "A1" => Cell.new("A1"),
               "A2" => Cell.new("A2"),
               "A3" => Cell.new("A3"),
               "A4" => Cell.new("A4"),
               "B1" => Cell.new("B1"),
               "B2" => Cell.new("B2"),
               "B3" => Cell.new("B3"),
               "B4" => Cell.new("B4"),
               "C1" => Cell.new("C1"),
               "C2" => Cell.new("C2"),
               "C3" => Cell.new("C3"),
               "C4" => Cell.new("C4"),
               "D1" => Cell.new("D1"),
               "D2" => Cell.new("D2"),
               "D3" => Cell.new("D3"),
               "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false if ship.length != coordinates.length

    valid_grid = valid_grid_allignment(coordinates)
    valid_grid[:letters].uniq.length == 1 && sequential?(valid_grid[:numbers])

  end

  def valid_grid_allignment(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      letters << coordinate.split(//).first.ord
      numbers << coordinate.split(//).last.to_i
    end

    {letters: letters, numbers: numbers}

    # (numbers[0]..numbers[-1]).to_a == numbers && letters.uniq.length == 1)
  end

  def sequential?(array)
    (array[0]..array[-1]).to_a == array
    # require "pry"; binding.pry
  end



  #gonna need a method that palces the ship in a range on cells
  # def place_ship_on_board(ship, coordinates)
  #
  # end

end
