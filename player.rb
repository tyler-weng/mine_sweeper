class Player
  def initialize(name="Player")
    @name = name
  end

  def prompt
    p "Select a position x, y"
    pos = gets.chomp.split(", ").map(&:to_i)
    p "Choose to reveal or flag: type r to reveal, f to flag"
    action = gets.chomp
    [pos, action]
  end
end
