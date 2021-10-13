class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]


  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char) ? true : false
  end

  def get_matching_indices(char)
    secret_word_array = @secret_word.split("")
    secret_word_array.each_index.select{ |i| secret_word_array[i] == char }
  end

  def fill_indices(char, array)
    @guess_word.map!.with_index do |element, index|
      if array.include?(index)
        char
      else
        element
      end
    end
  end

  def try_guess(char)
    if already_attempted?(char)
      print "That has already been attempted"
      return false
    else
      @attempted_chars << char
    end

    matching_indices = get_matching_indices(char)

    if matching_indices.length == 0
      @remaining_incorrect_guesses -= 1
    else
      fill_indices(char, matching_indices)
    end

    true
  end

  def ask_user_for_guess
    print "Enter a char: "
    char = gets.chomp
    try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      print "WIN\n"
      return true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print "LOSE\n"
      return true
    else
      false
    end
  end

  def game_over?
    if win? || lose?
      print "The secret word is " + @secret_word + "!\n"
      return true
    else
      false
    end
  end
end
