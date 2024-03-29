  class Ship
  attr_reader :name, :length, :sunk
  attr_accessor :health

  def initialize(name, length, sunk = false)
    @name = name
    @length = length
    @health = @length
    @sunk = sunk
  end

  def hit
    @health -= 1
  end

  def sunk?
    return true if @health == 0

    @sunk
  end
end
