class Tile
  attr_accessor :adjacents, :val

  def initialize(val = "0")
    @val = val
    @val == "b" ? @is_bomb = true : @is_bomb = false
    @explored = false
    @flagged = false
    @adjacents = []
  end

  def is_bomb?
    @is_bomb
  end

  def is_blank?
    !@val
  end

  def reveal_tile
    @explored = true
  end

  def flip_flag
    @flagged = @flagged ? false : true
  end

  def explored?
    @explored
  end

  def flagged?
    @flagged
  end
end
