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
    return false unless coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
    ship_overlap_stopper(coordinates)
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
  end

  def sequential?(coordinate_set)
    (coordinate_set[0]..coordinate_set[-1]).to_a == coordinate_set
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def ship_overlap_stopper(coordinates)
    coordinates.all? do |coordinate|
      @cells[coordinate].ship == nil
    end
  end

  def render(player = false)
    cells_on_a = @cells.keys[0..3]
    cells_on_b = @cells.keys[4..7]
    cells_on_c = @cells.keys[8..11]
    cells_on_d = @cells.keys[12..15]

    require "pry"; binding.pry
    #apply the cell.render method to a range of cells
    # the range should reflect numbers ie A1-A4


  end
end
