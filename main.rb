require 'colorize'
require 'pry'

# blackjack
# poker
# dice
# slots
# roulette

# CLASS
class Player
  attr_accessor :name, :money

  def initialize(name, money)
    @name = name
    @money = money
  end
  def moneycheck
    puts "You currently have $#{@money}"
  end
  def game
    bet_amount.to_i == 0
      puts #error message
      game
    elsif bet_amount == "0"
      intro
    elsif bet_amount.capitalize == "Back"
      puts "Good luck, then!"
      intro
    elsif bet_amount.capitalize == "Menu"
      puts #something
      intro
    elsif bet_amount.to_i < 5
      puts "You need at least $5 to play blackjack"
      game
    elsif bet_amount.to_i > @money
      puts "That's more than you have, buddy"
      puts "Try a different ammount"
      game

  end
end
#CLASS


def intro
 puts "Welcome to the Casino"
 puts "What is your name?"
 @player = gets.strip.capitalize
 @player = Player.new(@player.to_s, 300)
 puts "-------------------"
 puts "WELCOME #{@player.name.upcase}!"
 @player.moneycheck
 puts "What would you like to play?"
 puts "1) Blackjack"
 puts "2) Craps"
 puts "3) Slots"
 puts "4) Peace Out"
 puts "------------------"
 choice = gets.strip.to_i
 case choice
 when 1
   blackjack
 when 2
   craps
 when 3
   slots
 when 4
   exit
 else
   puts "------------"
   puts "--Wrong-O!--"
   puts "-Try Again!-"
   puts "------------"
 end
end

def blackjack
  puts " "
  puts "This is blackjack, dawg."
  puts " "
  blackjack_gets
end

def blackjack_gets
  puts "-------------------------------"
  puts "How much would you like to bet?"
  puts "Type 'Back' or 'Menu' to leave"
  puts "-------------------------------"
  bet_amount = gets.strip
  if
  @player.game
elsif bet_amount.to_i <= @money && bet_amount.to_i >= 5
  go_to_game
else
  puts "Invalid entry, please try again!"
end
end

def blackjack_game
  puts "Good job!"
 # Make game
end

def craps
  puts " "
  puts "This is blackjack, dawg."
  puts " "
  craps_gets
end

def craps_gets
  @player.game
end

def craps_game
  puts "Good job!"
 # Make game
end

def blackjack
  puts " "
  puts "This is blackjack, dawg."
  puts " "
  blackjack_gets
end

def blackjack_gets
  @player.game
end

def blackjack_game
  puts "Good job!"
 # Make game
end



intro
