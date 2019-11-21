class Player
  attr_accessor :name, :money

  def initialize(name, money)
    @name = name
    @money = money
  end
  def moneycheck
    puts "--You have $#{@money}!--"
  end
  def betloss(number)
    @money -= number.to_i
  end
  def bethalf(number)
    @money -= (number.to_i / 2)
  end
  def guesswin(number)
    @money += (number.to_i * 4)
  end
  def slotwin(number)
    @money += (number.to_i * 10)
  end
  def moneyadd(number)
    @money += number.to_i
  end
  def hlwin(number)
    @money += (number.to_i * 1.5)
  end
  def list
    puts "----------"
    puts "• #{@name}"
    puts "----------"
  end
  def welcome
    puts "-------------------"
    puts "--WELCOME #{@name.upcase}!--"
    puts "-------------------"
  end
end
