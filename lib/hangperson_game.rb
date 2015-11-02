class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses=""
    @wrong_guesses=""
    @display=""
    for i in 1..word.length
      @display+="-"
    end
    
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(let)
    
    if let=="" or let == nil
      raise ArgumentError
    end
    charset="abcdefghijklmnopqrstuvwxyz"
    if charset.index(let.downcase) == nil 
      raise ArgumentError 
    end
    
    if @guesses.index(let.downcase) != nil || @wrong_guesses.index(let.downcase) != nil
      return false
    else
      if (@word.index(let.downcase) != nil)
        @guesses += let
        
        
        for i in 0..(@word.length-1)
          if @word[i]==let
            @display[i]=let
          end
        end
        
      else
        @wrong_guesses += let
      end
      return true
    end
  end
  
  def word_with_guesses
    return @display
  end
  
  def check_win_or_lose
    if @display.index("-")==nil
      return :win
    else
      if @wrong_guesses.length>=7
        return :lose
      else
        return :play
      end
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end



def guess_several_letters(game_class,str)
  str.each_char{|x| game_class.guess(x)}
end