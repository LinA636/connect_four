require_relative '../lib/player'
require_relative '../lib/field'
require "colorize"
require "matrix"

class ConnectFour
  # ToDos
  # does not stop game after victory

  attr_accessor :field_matrix, :current_player, :player1, :player2

  def initialize
    @field_matrix = Matrix.build(6,7){Field.new}
    @player1 = Player.new("Player1", :red)
    @player2 = Player.new("Player2", :blue)
    @current_player = self.player1
  end

  def start_game
    print_board
    make_move
    print_board
    while !victory? && moves_left?
      update_current_player
      make_move
      print_board
    end
  end

  def victory?
    victory_in_row?
    victory_in_column?
    victory_in_diagonal?
  end

  def victory_in_row?
    number_of_rows = self.field_matrix.row_size
    for i in 0..number_of_rows-1
      if self.field_matrix.row(i).each_cons(4).any?{|cons| cons.all?{|field| field.is_set && field.symbol == self.current_player.symbol}}
        announce_winner
        return true
      end
    end 
    false
  end

  def victory_in_column?
    number_of_columns = self.field_matrix.column_size
    for i in 0..number_of_columns-1
        if self.field_matrix.column(i).each_cons(4).any?{|cons| cons.all?{|field| field.is_set && field.symbol == self.current_player.symbol}}
          announce_winner
        end
    end 
    false
  end

  def victory_in_diagonal?
    number_of_columns = self.field_matrix.column_size
    number_of_rows = self.field_matrix.row_size
    # check diagonal from left to right
    for i in 0..number_of_columns-4
      for j in i..number_of_rows-4
        if (0..3).all?{|k| self.field_matrix[j+k, i+k].is_set && self.field_matrix[j+k, i+k].symbol == self.current_player.symbol}
          announce_winner
        end
      end
    end
    # check diagonal from right to left
    for i in 0..number_of_columns-4
      for j in i..number_of_rows-4
        if (0..3).all?{|k| self.field_matrix[j+k, i+(3-k)].is_set && self.field_matrix[j+k, i+(3-k)].symbol == self.current_player.symbol}
          announce_winner
        end
      end
    end
    false
  end

  def moves_left?
    if self.current_player.played_discs < 21
      self.current_player.played_discs += 1
      return true
    else
      announce_tie
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
    puts " 1 2 3 4 5 6 7 "
  end

  def make_move
    column_index = choose_column
    drop_disc(column_index)
  end

  def choose_column
    puts "#{current_player.name} choose a column: "
    column_index = gets.chomp.to_i
    column_index -= 1
    if column_exists?(column_index) && !column_full?(column_index)
      column_index
    else
      choose_column()
    end
  end

  def column_exists?(column_index)
    0 <= column_index && column_index <= 6
  end

  def column_full?(column_index)
    column = self.field_matrix.column(column_index).to_a
    column.all?{|field| field.is_set == true}
  end

  def drop_disc(column_index)
    field = self.field_matrix.column(column_index).to_a.select{|field| field.is_set == false}.last
    field.is_set = true
    field.symbol = self.current_player.symbol
  end

  def announce_tie
    puts "There are no more moves left. It's a tie!"
    exit
  end

  def announce_winner
    puts "Congratulation! #{current_player.name} wins."
    exit
  end

end