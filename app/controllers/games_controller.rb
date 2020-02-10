require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    alphabet = ('A'..'Z').to_a
    9.times do
      @letters << alphabet.sample
    end
    @letters
  end

  def score
    if english_check?(@suggestion) && grid_check?(@letters, @suggestion)
      "Congratulations! #{@suggestion} is a valid word."
    elsif english_check?(@suggestion) == false
      "Sorry but #{@suggestion} is not a valid word."
    else
      "Sorry but #{@suggestion} is not a valid word."
    end
  end

  def english_check?(attempt)
    url = 'https://wagon-dictionary.herokuapp.com/:'
    result = JSON.parse(open("#{url}#{attempt}").read)
    result[:found]
  end

  def grid_check?(grid, attempt)
    attempt.each do |letter|
      grid.include?(letter)
      grid.delete(letter) # remove letter from grid
    end
  end
end
