# frozen_string_literal: true

class Player
  attr_accessor :symbol, :played_discs, :name

  def initialize(name, color_name)
    @symbol = "\u{23FA}".colorize(color_name)
    @played_discs = 0 
    @name = name
  end
end