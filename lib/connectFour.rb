require_relative '../lib/player'
require_relative '../lib/field'
require "colorize"
require "matrix"

class ConnectFour

  attr_accessor :field_matrix, :current_player, :player1, :player2

  def initialize
    @field_matrix = Matrix.build(6,7){Field.new}
    @player1 = Player.new('red')
    @player2 = Player.new('black')
    @current_player = self.player1
  end

  def start_game
    while !victory? && moves_left?
      update_current_player
      print_board
      make_move
    end
  end

  def victory?

  end

  def moves_left?
    if self.current_player.played_discs < 21
      self.current_player.played_discs += 1
      return true
    else
      announce_tie
      end_game
    end
  end

  def update_current_player
    if self.current_player == self.player1
      self.current_player = self.player2
    else
      self.current_player = self.player1
    end
  end

  def print_board
    puts "\n 1 2 3 4 5 6 7 "
    puts "+-+-+-+-+-+-+-+"
    self.field_matrix.row_vectors.each do |row|
      puts "|#{row.to_a.join('|')}|"
      puts "+-+-+-+-+-+-+-+"
    end
  end

  def make_move

  end

  def announce_tie

  end

  def end_game
    
  end
end