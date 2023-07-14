class Player
  attr_accessor :symbol, :played_discs

  def initialize(color_name)
    @symbol = "\u{23FA}".colorize(color_name)
    @played_discs = 0 
  end
end