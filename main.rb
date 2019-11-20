require 'colorize'
require 'pry'
require_relative 'deck'
require_relative 'card'
require_relative 'dice'


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
    @money -= number
  end
  def betwin
    @money #something... I have no idea how gamble winnings work
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
  @player = Player.new(@player, 500)
  @gamblers << @player
  @player.welcome
  menu
end

def menu
  @player.moneycheck
  puts "-------------------"
  puts "What would you like to do?"
  puts "1) Play Blackjack"
  puts "2) Play Guess The Total"
  puts "3) Play Slots"
  puts "4) Change user"
  puts "5) Peace Out"
  puts "------------------"
  @choice = gets.strip.to_i
 case @choice
 when 1
   blackjack
 when 2
   guess_the_total
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
  puts "Type 'Back' or 'Menu' to leave"
  puts "-------------------------------"
  bet_amount = gets.strip
  if bet_amount == "0"
    puts "------------------------------"
    puts "No bets equals no game, buddy!"
    menu
  elsif bet_amount.capitalize == "Back"
    puts "-------------"
    puts "Best of luck!"
    menu
  elsif bet_amount.capitalize == "Menu"
    puts "-------------"
    puts "Best of luck!"
    menu
  elsif bet_amount.capitalize == "Return"
    puts "-------------"
    puts "Best of luck!"
    menu
  elsif bet_amount.to_i == 0
    puts "-----------------------------------------"
    puts "Your bettin' money, bub! Not your mother."
    bet
  elsif bet_amount.to_i < 5
    puts "You need to bet least $5 to play blackjack"
    bet
  elsif bet_amount.to_i > @player.money
    puts "That's more than you have, buddy!"
    puts "Try a different ammount"
    bet
  elsif bet_amount.to_i <= @player.money
    direction
  elsif bet_amount.to_i >= 5
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
    guess_the_total_game
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
  # puts "Good job B!"
  # @player.betloss(20)
 # Make game
 menu
end
# --------------------------
def guess_the_total
  puts "^^^^^^^^^^^^^^^^^^^^"
  puts "This is Guess The Total, dawg!"
  puts "^^^^^^^^^^^^^^^^^^^^"
  bet
end
def guess_the_total_game
  puts "Take a LUCKY guess!"
  person = gets.strip

  dice = Dice.new
  dice.show_sum

  if person == dice.show_sum
    puts "^^^^^^^^^^^^^^^^^^^^"
    puts " WINNER WINNER! CHICKEN DINNER!"
    puts "^^^^^^^^^^^^^^^^^^^^"
  else
    puts "^^^^^^^^^^^^^^^^^^^^"
    puts "Awww! TOO BAD!"
    puts "^^^^^^^^^^^^^^^^^^^^"
    bet
  end



 menu
end

def slots
  puts "^^^^^^^^^^^^^^^^^^^^"
  puts "This is slots, dawg!"
  puts "^^^^^^^^^^^^^^^^^^^^"
  bet
end
def slots_game
  # puts "Good job S!"
  # @player.betloss(60)
 # Make game
 menu
end

def user_change
    puts "-------------------------"
    puts "Who will be playing next?"
    puts "-------------------------"
    @name = gets.strip.capitalize
    @gamblers.each {|person|
      if @name == person.name
        @player = person
        @player.welcome
        menu
      end}
  if @name == @player.name
    puts "------------------------------"
    puts "You're already playing, silly!"
    user_change
  else
    @name = Player.new(@name, 500)
    @gamblers << @name
    @player = @name
    @player.welcome
    menu
  end
end

def exit
  puts "------------------"
  puts "--SEE YOU SOON!!--"
  puts "------------------"
end

intro