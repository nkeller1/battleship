class Cell
  attr_reader :ship, :coordinate

  def initialize (coordinate)
  @coordinate = coordinate
  @ship = nil

  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_arg)

    @ship = ship_arg

  end

end
