# Worked with Deana

# Problem 1.a
def palindrome?(string)
 string = string.downcase.gsub(/\W/, "")
 string == string.reverse
end

puts palindrome?("A man, a plan, a canal -- Panama") #=> true
puts palindrome?("Madam, I'm Adam!") # => true
puts palindrome?("Abracadabra") # => false (nil is also ok)
puts palindrome?("Eva, can I stab bats in a cave?") # => true
puts palindrome?("It's disappointing that the word palindrome is not a palindrome.") # => false
puts 

# Problem 1.b 
# We purposely didn't filter out apostrophes in the regular expression because 
# we didn't want don't to become dont
def count_words(string)
  string_array = string.downcase.gsub(/[^\w\s']/, "").split
  word_hash = Hash.new(0)
  string_array.each { |word|
    word_hash[word] += 1
  }
  return word_hash
end

puts count_words("A man, a plan, a canal -- Panama")
# => {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
puts count_words "Doo bee doo bee doo" # => {'doo' => 3, 'bee' => 2}
puts count_words "Don't bee doo bee doo" # => {"don't"=>1, "bee"=>2, "doo"=>2}
puts

# Problem 2.a
class WrongNumberOfPlayersError < StandardError 
  def initialize(message="Wrong number of players.")
    super(message)
  end
end

class NoSuchStrategyError < StandardError 
  def initialize(message="Strategy does not exist.")
    super(message)
  end
end
  
def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2
  strategy0 = game[0][1].downcase
  strategy1 = game[1][1].downcase
  raise NoSuchStrategyError unless (strategy0 =~ /^[rps]$/ && strategy1 =~ /^[rps]$/)
  if strategy0 == strategy1
   return game[0]
  elsif strategy0 == "r" && strategy1 == "s" || strategy0 == "s" && strategy1 == "p" || strategy0 == "p" && strategy1 == "r"
    return game[0]
  else
    return game[1]
  end
end

p rps_game_winner([[ "Armando", "P" ], [ "Dave", "S" ]])
p rps_game_winner([[ "Lucia", "R" ], [ "Josh", "P" ]])
p rps_game_winner([[ "Glo", "S" ], [ "Emma", "R" ]])
p rps_game_winner([[ "Alfie", "P" ], [ "Clancy", "P" ]])
# Game with error, uncomment below to run and see error message.
# p rps_game_winner([[ "Bob", "B" ], [ "Emma", "R" ]])
puts

# Problem 2.b
def rps_tournament_winner(tournament)
  if (tournament[0][0].class == String)
    rps_game_winner(tournament)
  else
    rps_game_winner([rps_tournament_winner(tournament[0]), rps_tournament_winner(tournament[1])])
  end
end

rps_tournament_1 = [
  [
   [ ["Armando", "P"], ["Dave", "S"] ], 
   [ ["Richard", "R"], ["Michael", "S"] ], 
  ], 
  [
   [ ["Allen", "S"], ["Omer", "P"] ],
   [ ["David E.", "R"], ["Richard X.", "P"] ]
  ]
] 
rps_tournament_2 = [[["Sarah", "S"], ["Pablo", "P"]], [["John", "R"], ["Peter", "P"]]]
rps_tournament_3 = [[["Sarah", "S"], ["Pablo", "P"]], [["John", "R"]]]
p rps_tournament_winner(rps_tournament_1)
p rps_tournament_winner(rps_tournament_2)
# Game with error (wrong number of players), uncomment to test
# p rps_tournament_winner(rps_tournament_3)
puts

# Problem 3 (Almudena said doing it with group_by is okay)
def combine_anagrams(words)
  words.group_by { |word|
    word.downcase.chars.sort
  }.values
end

p combine_anagrams(['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams', 'scream'] )
p combine_anagrams(['listen', 'Are', 'silent', 'ear', 'Heart','era', 'creams', 'earth'] )
p combine_anagrams(['Natasha', 'Deana', 'Gloriane', 'Regina'] )
puts

# Problem 4.a
class Dessert
  attr_accessor :name
  attr_accessor :calories
  
  def initialize(name, calories)
  @name = name
  @calories = calories
  end

  def healthy?
    return calories < 200
  end

  def delicious?
    return true
  end
end

# Problem 4.b
class JellyBean < Dessert
  attr_accessor :flavor
  def initialize(name, calories, flavor)
    @flavor = flavor
    super(name, calories)
  end

  def delicious?
    if flavor == "black licorice"
      return false
    end
    super
  end
end

gross_bean = JellyBean.new("not cool bean", 5, "black licorice")
puts  "This jellybean's flavor is #{gross_bean.flavor}."
puts "Is this jellybean delicious? #{gross_bean.delicious?}"
gross_bean.flavor = "orange"
puts "This jellybean's flavor is now #{gross_bean.flavor}."
puts "Is this jellybean delicious? #{gross_bean.delicious?}"

carrot = Dessert.new("carrot cake", 150)
puts "Is #{carrot.name} delicious? #{carrot.delicious?}"
puts "Is #{carrot.name} (#{carrot.calories} calories) healthy? #{carrot.healthy?}"

chocolate = Dessert.new("chocolate cake", 5000)
puts "Is #{chocolate.name} delicious? #{chocolate.delicious?}"
puts "Is #{chocolate.name} (#{chocolate.calories} calories) healthy? #{chocolate.healthy?}"
chocolate.calories = 199
puts "I found a healthier recipe! This #{chocolate.name} is now #{chocolate.calories} calories."
chocolate.name = "chocolate cream pie"
puts "I changed my mind. I'm going to eat a #{chocolate.name} instead."
