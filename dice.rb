class Dice
  def initialize
    roll
  end
  def roll
    @die1 = 1 + rand(6)
    @die2 = 1 + rand(6)
  end
  def show_dice
    puts "Die1: #{@die1}"
    puts "Die2: #{@die2}"
    puts "Dice total is: #{@die1 + @die2}"
    @total = @die1 + @die2
  end
  def guess
    @total
  end
end
