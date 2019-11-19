require 'colorize'
require 'pry'

# dice
# roulette

# CLASS
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
  def betwin(number)
    @money += (number.to_i * 2) #I have no idea how gamble winnings work
  end
  def slotwin(number)
    @money += (number.to_i * 10)
  end
  def welcome
    puts "-------------------"
    puts "--WELCOME #{@name.upcase}!--"
    puts "-------------------"
  end
end
#CLASS

@gamblers = []

def intro
  puts "----------------------"
  puts "Welcome to the Casino!"
  puts "What is your name?"
  @player = gets.strip.capitalize
  depositmoney
end
def depositmoney
  puts "How much would you like to deposit?"
  deposit = gets.strip.to_i
  if deposit == 0
    puts "---------------------------------"
    puts "You can only deposit money, silly!"
    puts "---------------------------------"
    depositmoney
  elsif deposit < 5
    puts "-----------------------------------------"
    puts "You'll need at least $5 to play any game."
    puts "-----------------------------------------"
    depositmoney
  elsif deposit >= 5
  @player = Player.new(@player, deposit)
  @gamblers << @player
  @player.welcome
  menu
  end
end

def menu
  @player.moneycheck
  puts "-------------------"
  puts "What would you like to do?"
  puts "1) Play Blackjack"
  puts "2) Play Craps"
  puts "3) Play Slots"
  puts "4) Change user"
  puts "5) Peace Out"
  puts "------------------"
  @choice = gets.strip.to_i
 case @choice
 when 1
   blackjack
 when 2
   craps
 when 3
   slots
 when 4
   user_change
 when 5
   exit
 else
   puts "------------"
   puts "--Wrong-O!--"
   puts "-Try Again!-"
   puts "------------"
 end
end

def bet
  puts "-------------------------------"
  puts "How much would you like to bet?"
  @player.moneycheck
  puts "Type 'Back' or 'Menu' to leave"
  puts "-------------------------------"
  @bet_amount = gets.strip
  if @bet_amount == "0"
    puts "------------------------------"
    puts "No bets equals no game, buddy!"
    menu
  elsif @bet_amount.capitalize == "Back"
    puts "-------------"
    puts "Best of luck!"
    menu
  elsif @bet_amount.capitalize == "Menu"
    puts "-------------"
    puts "Best of luck!"
    menu
  elsif @bet_amount.capitalize == "Return"
    puts "-------------"
    puts "Best of luck!"
    menu
  elsif @bet_amount.to_i == 0
    puts "-----------------------------------------"
    puts "Your bettin' money, bub! Not your mother."
    bet
  elsif @bet_amount.to_i < 5
    puts "You need to bet least $5 to play blackjack"
    bet
  elsif @bet_amount.to_i > @player.money
    puts "That's more than you have, buddy!"
    puts "Try a different ammount"
    bet
  elsif @bet_amount.to_i <= @player.money
    direction
  elsif @bet_amount.to_i >= 5
    direction
  else
    puts "Invalid entry, please try again!"
    bet
  end
end

def direction
  if @choice == 1
    blackjack_game
  elsif @choice == 2
    craps_game
  elsif @choice == 3
    slots_game
  else
    menu
  end
end

def blackjack
  puts "^^^^^^^^^^^^^^^^^^^^^^^^"
  puts "This is blackjack, dawg!"
  puts "^^^^^^^^^^^^^^^^^^^^^^^^"
  bet
end
def blackjack_game
  puts "Hit 1 to lose!"
  puts "Hit 2 to win!"
  winlose = gets.strip.to_i
  case winlose
  when 1
    @player.betloss(@bet_amount)
    puts "-----------------"
    puts "Sorry, you lost!!"
    puts "-----------------"
    menu
  when 2
    @player.betwin(@bet_amount)
    puts "--------------"
    puts "Yay! You won!!"
    puts "--------------"
    menu
  else
    puts "Invalid entry, please try again!"
    direction
  end
 # Make game
end

def craps
  puts "^^^^^^^^^^^^^^^^^^^^"
  puts "This is craps, dawg!"
  puts "^^^^^^^^^^^^^^^^^^^^"
  bet
end
def craps_game
  puts "Hit 1 to lose!"
  puts "Hit 2 to win!"
  winlose = gets.strip.to_i
  case winlose
  when 1
    @player.betloss(@bet_amount)
    puts "-----------------"
    puts "Sorry, you lost!!"
    puts "-----------------"
    menu
  when 2
    @player.betwin(@bet_amount)
    puts "--------------"
    puts "Yay! You won!!"
    puts "--------------"
    menu
  else
    puts "Invalid entry, please try again!"
    direction
  end
 # Make game
end

def slots
  puts "^^^^^^^^^^^^^^^^^^^^"
  puts "This is slots, dawg!"
  puts "^^^^^^^^^^^^^^^^^^^^"
  bet
end
def slots_game
  puts "Hit enter to pull the lever!"
  lever = gets.strip
  @slot1 = ["§", "¶", "•", "£", "¢", "∞"]
  @slot2 = ["§", "¶", "•", "£", "¢", "∞"]
  @slot3 = ["§", "¶", "•", "£", "¢", "∞"]
  @bar = []
  @bar1 = []
  @bar2 = []
  @bar << @slot1.sample
  @bar1 << @slot2.sample
  @bar2 << @slot3.sample
  puts @bar[0]
  puts @bar1[0]
  puts @bar2[0]
  if @bar[0] == @bar1[0] && @bar1[0] != @bar2[0]
    puts "------------------"
    puts "You got your money back!"
    @bar.clear
    @bar1.clear
    @bar2.clear
    bet
  elsif @bar[0] != @bar1[0] && @bar1[0] == @bar2[0]
    puts "------------------"
    puts "You got your money back!"
    @bar.clear
    @bar1.clear
    @bar2.clear
    bet
  elsif @bar[0] == @bar2[0] && @bar2[0] != @bar1[0]
    puts "------------------"
    puts "You got your money back!"
    @bar.clear
    @bar1.clear
    @bar2.clear
    bet
  elsif @bar[0] == @bar1[0] && @bar1[0] == @bar2[0]
    puts "-------------------"
    puts "YOU FRIGGIN WON!!!!"
    @player.slotwin(@bet_amount)
    @bar.clear
    @bar1.clear
    @bar2.clear
    bet
  else
    puts "----------"
    puts "Awe... Too bad!!"
    @player.betloss(@bet_amount)
    @bar.clear
    @bar1.clear
    @bar2.clear
    bet
  end
end

def user_change
    puts "-------------------------"
    puts "Who will be playing next?"
    puts "-------------------------"
    @name = gets.strip.capitalize
  if @name == @player.name
    puts "------------------------------"
    puts "You're already playing, silly!"
    user_change
  end
    @gamblers.each {|person|
    if @name == person.name
      @player = person
      @player.welcome
      menu
    end}
  if @name != @player.name
    @player = @name
    depositmoney
  end
end

def exit
  puts "------------------"
  puts "--SEE YOU SOON!!--"
  puts "------------------"
end

intro
