require "colorize"

class Field
  attr_accessor :is_set, :symbol

  def initialize(is_set = false)
    @is_set = is_set
    @symbol ="\u{20DD} "
  end

  def to_s
    self.symbol
  end
end