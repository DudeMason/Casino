class Dice
  def initialize 
    roll
  end
  
  def roll
    @dice1 = rand(6)
    @dice2 = rand(6)
  end

  def show_dice
    print "Dice1: ", @dice1, "Dice2: ", @dice2
  end
  
  def show_sum
    print "Dice total is: ", @dice1 + @dice2, ".\n"
    return @dice1 + @dice2
  end
end
