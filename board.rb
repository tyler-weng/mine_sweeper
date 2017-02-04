require_relative "tile"
require 'byebug'

class Board
  attr_reader :board
  DIRECTIONS = [[-1, 1], [-1,0], [-1, -1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  def initialize(board_size = 9, num_bombs = 10)
    @board = Array.new(board_size) { Array.new(board_size) }
    @num_bombs = num_bombs
    @board_size = board_size
    populate_board
  end

  def populate_board
    populate_blanks
    populate_bombs
    @flat.shuffle!
    (0...@board_size).each do |i|
      (0...@board_size).each do |j|
        @board[i][j] = @flat.shift
      end
    end
    populate_nums
  end

  def populate_bombs
    @num_bombs.times { @flat << Tile.new("b")}
  end

  def populate_blanks
    @flat = []
    (@board_size ** 2 - @num_bombs).times { @flat << Tile.new }
  end

  def populate_nums
    @board.each.with_index do |row, ri|
      row.each.with_index do |tile, ci|
        populate_tile_adjacents([ri, ci])
      end
    end
  end


  # adjacents working as intended
  def adjacents(pos)
    x, y = pos
    adjs = []
    DIRECTIONS.each do |dir|
      adj = [x+dir[0], y+dir[1]]
      adjs << adj unless out_of_bounds?(adj)
    end
    adjs
  end

  def get_tile(pos)
    @board[pos[0]][pos[1]]
  end

  def populate_tile_adjacents(pos)
    adjs = adjacents(pos)
    tile = get_tile(pos)
    return if tile.val == "b"
    adjs.each do |adj|
      adj_tile = get_tile(adj)
      if adj_tile.val == "b"
        tile.val = (tile.val.to_i + 1).to_s
      end
    end
  end

  def out_of_bounds?(pos)
    !((0...@board_size).include?(pos[0])) || !((0...@board_size).include?(pos[1]))
  end

  def [](pos)
    x, y = pos
    @board[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @board[x][y] = val
  end

  def show_all #show all
    @board.each do |row|
      row.each do |tile|
        print "#{tile.val}|"
      end
      print "\n"
    end
  end

  #is call adj tiles on pos, and keep exploring/revealing tiles until n
  def explore(pos)
  end

  # handle tile will only happen if player selects reveal as action
  def handle_flip(pos)
    tile = get_tile(pos)
    return tile.reveal_tile if tile.val == "b" || tile.val.to_i > 0

    #recursive call to handle 0s
    possibles = [pos]
    until possibles.empty?
      curr_pos = possibles.shift
      adjs = adjacents(curr_pos)
      adjs.each do |adj|
        handle_flip(adj)
        adj_tile = get_tile(adj)
      end
    end

  end



  def game_over?(pos)
    tile = get_tile(pos)
    if tile.val == "b" && tile.explored?
      return true
    elsif @board.flatten.any? {|tile| !(tile.explored)|| !(tile.flagged?)}
      return false
    else
      true
    end
  end

end

# b = Board.new
# b.populate_board
