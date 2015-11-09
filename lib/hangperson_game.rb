class HangpersonGame
    
  MAX_FAILED_ATTEMPTS = 7
  
  attr_accessor :word
  attr_accessor :selected_letters
  attr_accessor :wrong_guesses
  attr_accessor :guesses
  attr_accessor :word_with_guesses
  attr_accessor :check_win_or_lose

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = word.gsub(/./, "-") 
    @check_win_or_lose = :play
    @wrong_count = 0
  end

  def guess(guess_letter)

=begin
    if guess_letter.nil?
      raise ArgumentError, "Guess letter should not be nil"
    end

    if guess_letter.to_s == "" 
      raise ArgumentError, "Guess letter should not be empty" 
    end
    
    if guess_letter =~ /[^[:alpha:]]/
      raise ArgumentError, "Please only select letters"
    end
=end
   # if guess_letter =~ /[^a-z]/i
      raise ArgumentError, "Invalid input" unless guess_letter =~/[a-z]/i
   # end

    if @guesses =~ Regexp.new(Regexp.escape(guess_letter)) || @wrong_guesses =~ Regexp.new(Regexp.escape(guess_letter))
      return false 
    end
     
    if guess_letter =~ /[[:upper:]]/
      return false
    end

    if @word =~ Regexp.new(Regexp.escape(guess_letter))
      @guesses += guess_letter
      @word_with_guesses = @word.gsub(Regexp.new("[^"+@guesses+"]"),"-" )
      @check_win_or_lose = :win unless @word_with_guesses =~ /[\-]/
    else  
      @wrong_guesses += guess_letter
      @wrong_count += 1
      if @wrong_count >= MAX_FAILED_ATTEMPTS
       @check_win_or_lose = :lose
      end
    end  
    return true
  end


 def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
