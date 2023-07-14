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
  
end