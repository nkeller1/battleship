class Cell
  attr_reader :ship, :coordinate

  def initialize(coordinate, fired_upon = false)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = fired_upon
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_arg)
    @ship = ship_arg
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if empty? == false
      @ship.health -= 1
    end
  end

  def render(player = false)
    return "S" if player == true && empty? == false 
    return "M" if fired_upon? == true && empty? == true
    return "X" if fired_upon? == true && @ship.sunk? == true
    return "H" if fired_upon? == true && empty? == false
    "."
  end


end
