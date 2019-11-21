require 'colorize'
require 'pry'
require_relative 'dice'
require_relative 'player'

@gamblers = []
@dice = Dice.new
@cards_high_low = [
  {card: 'Ace', value: 1},
  {card: '2', value: 2},
  {card: '3', value: 3},
  {card: '4', value: 4},
  {card: '5', value: 5},
  {card: '6', value: 6},
  {card: '7', value: 7},
  {card: '8', value: 8},
  {card: '9', value: 9},
  {card: '10', value: 10},
  {card: 'Jack', value: 11},
  {card: 'Queen', value: 12},
  {card: 'King', value: 13}
  ]

def intro
  puts "----------------------"
  puts "Welcome to the Casino!"
  puts "What is your name?"
  @player = gets.strip.capitalize
  if @player.to_i >= 1
    puts "You should probably use letters."
    intro
  elsif @player == "0"
    puts "You should probably use letters."
    intro
  else
    depositmoney
  end
end

def depositmoney
  puts "How much would you like to deposit?"
  deposit = gets.strip
  if deposit == "0"
    puts "--------------------------"
    puts "You'll need money to play!"
    puts "--------------------------"
    depositmoney
  elsif deposit.to_i == 0
    puts "---------------------------------"
    puts "You can only deposit money, silly!"
    puts "---------------------------------"
    depositmoney
  elsif deposit.to_i < 5
    puts "-----------------------------------------"
    puts "You'll need at least $5 to play any game."
    puts "-----------------------------------------"
    depositmoney
  elsif deposit.to_i >= 5
  @player = Player.new(@player, deposit.to_i)
  @gamblers << @player
  @player.welcome
  menu
  end
end

def menu
  @player.moneycheck
  puts "-------------------"
  puts "What would you like to do?"
  puts "1) Play High/Low!"
  puts "2) Guess-the-Total!"
  puts "3) Play Slots!"
  puts "4) User Menu"
  puts "5) Peace Out"
  puts "------------------"
  @choice = gets.strip.to_i
 case @choice
 when 1
   highlow
 when 2
   guess_the_total
 when 3
   slots
 when 4
   user_menu
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
    puts "You need to bet least $5 to play!"
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
    highlow_game
  elsif @choice == 2
    guess_the_total_game
  elsif @choice == 3
    slots_game
  else
    menu
  end
end

def highlow
  puts "§§§§§§§§§§§§§§§§§§§§".colorize(:green)
  puts "••••••••••••••••••••".colorize(:light_blue)
  puts "^^^^^^^^^^^^^^^^^^^^".colorize(:yellow)
  puts "--This is High/Low!--"
  puts "^^^^^^^^^^^^^^^^^^^^".colorize(:yellow)
  puts "••••••••••••••••••••".colorize(:light_blue)
  puts "§§§§§§§§§§§§§§§§§§§§".colorize(:green)
  bet
end

def highlow_game
  first_card = @cards_high_low.sample
  second_card = @cards_high_low.sample
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  puts "The dealer draws a #{first_card[:card]} which has a value of #{first_card[:value]}!"
  puts "Time to bet, High or Low?"
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^"
  high_low_validated = false
    while !high_low_validated
      high_or_low = gets.strip.downcase
      if high_or_low == "high" || high_or_low == "low"
        high_low_validated = true
      else
        puts "Please type either 'high' or 'low'"
      end
    end
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  puts "The dealer’s second card is a #{second_card[:card]} which has a value of #{second_card[:value]}"
  case true
  when first_card[:value] == second_card[:value]
    puts "•••••••"
    puts "•Draw!•"
    puts "•••••••"
    first_card
    bet
  when high_or_low == "high" && first_card[:value] < second_card[:value]
    @player.hlwin(@bet_amount)
    puts "••••••••"
    puts "YOU WON!"
    puts "••••••••"
    bet
  when high_or_low == "high" && first_card[:value] > second_card[:value]
    @player.betloss(@bet_amount)
    puts "••••••••••••••"
    puts "AWWW, TOO BAD!"
    puts "••••••••••••••"
    bet
  when high_or_low == "low" && first_card[:value] > second_card[:value]
    @player.hlwin(@bet_amount)
    puts "••••••••••"
    puts "•YOU WON!•"
    puts "••••••••••"
    bet
  when high_or_low == "low" && first_card[:value] < second_card[:value]
    @player.betloss(@bet_amount)
    puts "••••••••••••••••"
    puts "•AWWW, TOO BAD!•"
    puts "••••••••••••••••"
    bet
  else
    puts "Sorry, something went wrong..."
    menu
  end
end

def guess_the_total
  puts "§§§§§§§§§§§§§§§§§§§§".colorize(:green)
  puts "••••••••••••••••••••".colorize(:light_blue)
  puts "^^^^^^^^^^^^^^^^^^^^".colorize(:yellow)
  puts "--Guess the total!--"
  puts "^^^^^^^^^^^^^^^^^^^^".colorize(:yellow)
  puts "••••••••••••••••••••".colorize(:light_blue)
  puts "§§§§§§§§§§§§§§§§§§§§".colorize(:green)
  bet
end

def guess_the_total_game
  puts "Take a LUCKY guess!"
  lucky = gets.strip.to_i
  @dice.show_dice
  if lucky == 0
    puts "----------------------------------"
    puts "You have to guess a number, silly!"
    @dice.roll
    bet
  elsif lucky > 12
    puts "-------------------------------"
    puts "You can't guess higher than 12!"
    @dice.roll
    bet
  elsif lucky < 2
    puts "-------------------------------------"
    puts "You can't guess less than two, dummy!"
    @dice.roll
    bet
  elsif lucky == @dice.guess
    puts "^^^^^^^^^^^^^^^^^^^^"
    puts " WINNER WINNER! CHICKEN DINNER!"
    puts "^^^^^^^^^^^^^^^^^^^^"
    @player.guesswin(@bet_amount)
    @dice.roll
    bet
  elsif lucky != @dice.guess
    puts "^^^^^^^^^^^^^^^^^^^^"
    puts "---AWWW! TOO BAD!---"
    puts "^^^^^^^^^^^^^^^^^^^^"
    @player.betloss(@bet_amount)
    @dice.roll
    bet
  else
    puts "---------------------------"
    puts "Oops! Something went wrong!"
    puts "---------------------------"
    @dice.roll
    bet
  end
end

def slots
  puts "§§§§§§§§§§§§§§§§§§§§".colorize(:green)
  puts "••••••••••••••••••••".colorize(:light_blue)
  puts "^^^^^^^^^^^^^^^^^^^^".colorize(:yellow)
  puts "This is slots, dawg!"
  puts "^^^^^^^^^^^^^^^^^^^^".colorize(:yellow)
  puts "••••••••••••••••••••".colorize(:light_blue)
  puts "§§§§§§§§§§§§§§§§§§§§".colorize(:green)
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
  print @bar[0]
  print @bar1[0]
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

def user_menu
  puts "--------------------------"
  puts "What would you like to do?"
  puts "1) Add User"
  puts "2) Edit User"
  puts "3) Delete User"
  puts "4) Return to Menu"
  puts "--------------------------"
  input = gets.strip.to_i
  case input
  when 0
    puts "--------------------------"
    puts "Only menu options, please."
    user_menu
  when 1
    user_change
  when 2
    @gamblers.each {|person| person.list}
    puts "----------------------------------"
    puts "Which user would you like to edit?"
    puts "----------------------------------"
    input1 = gets.strip.capitalize
    @gamblers.each {|person|
    if input1 == person.name
      @edit = person
      edit_user
    else
      puts "Must be existing user."
      user_menu
    end}
  when 3
    if @gamblers.count >= 2
      @gamblers.each {|person| person.list}
      puts "Which user would you like to delete?"
      input2 = gets.strip.capitalize
      @gamblers.each {|person|
      if input2 == person.name
        @gamblers.delete(person)
        puts "•••••••••••••••"
        puts "•User deleted!•"
        puts "•••••••••••••••"
        user_menu
      else
        puts "-----------------------"
        puts "-Must be existing user-"
        puts "-----------------------"
        user_menu
      end}
    elsif @gamblers.count == 1
      @gamblers.each {|person| person.list}
      puts "Which user would you like to delete?"
      input2 = gets.strip.capitalize
      @gamblers.each {|person|
      if input2 == person.name
        @gamblers.delete(person)
        puts "•••••••••••••••"
        puts "•User deleted!•"
        puts "•••••••••••••••"
        intro
      else
        puts "-----------------------"
        puts "-Must be existing user-"
        puts "-----------------------"
        user_menu
      end}
    else
      puts "Something went wrong!"
      user_menu
    end
  when 4
    menu
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

def edit_user
  puts "--------------------------"
  puts "What would you like to do?"
  puts "1) Add Money"
  puts "2) Change Name"
  puts "3) Return to Menu"
  puts "--------------------------"
  input = gets.strip.to_i
  case input
  when 0
    puts "-----------------------------------"
    puts "Only menu option entries will work."
    edit_user
  when 1
    puts "How much money would you like to add?"
    money = gets.strip.to_i
      if money == 0
        puts "------------------------------"
        puts "Must be at least $1 or higher!"
        edit_user
      elsif money >= 1000
        puts "-------------------"
        puts "Dayummm!! You rich!"
        @edit.moneyadd(money)
        @edit.moneycheck
        user_menu
      elsif money >= 1
        puts "------------"
        puts "Money Added!"
        @edit.moneyadd(money)
        @edit.moneycheck
        user_menu
      else
        puts "----------------------"
        puts "Something went wrong!!"
        edit_user
      end
    when 2
      puts "Type the new name."
      name = gets.strip.capitalize
      if name.to_i >= 1
        puts "--------------------------------"
        puts "You should probably use letters."
        edit_user
      elsif name.to_i == "0"
        puts "--------------------------------"
        puts "You should probably use letters."
        edit_user
      else
        @edit.name = name
        puts "--------------"
        puts "Name changed!!"
        user_menu
      end
    when 3
      user_menu
  end
end

def exit
  puts "------------------"
  puts "--SEE YOU SOON!!--"
  puts "------------------"
end

intro
