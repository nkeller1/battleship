class Cell
  attr_reader :ship, :coordinate


  def initialize(coordinate, fired_upon = false, ship = nil)
    @coordinate = coordinate
    @ship = ship
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
    if player == true && @ship != nil && @fired_upon == false
      "S"
    elsif @ship != nil && @ship.health == 0 && @fired_upon == true
      "X"
    elsif @ship != nil && @ship.health > 0 && @fired_upon == true
      "H"
    elsif @ship == nil && @fired_upon == true
      "M"
    else
      "."
    end
  end
end
