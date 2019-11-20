class Dice
  def initialize
    roll
  end
  def roll
    @dice1 = 1 + rand(6)
    @dice2 = 1 + rand(6)
  end
  def show_dice
    puts "Dice1: #{@dice1}"
    puts "Dice2: #{@dice2}"
    puts "Dice total is: #{@dice1 + @dice2}"
    @total = @dice1 + @dice2
  end
  def guess
    @total
  end
end
