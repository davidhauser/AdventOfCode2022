# frozen_string_literal: true

# Class that defines various class methods to solve AoC D02P1
class Day02Problem1
  attr_accessor :matches

  module RockPaperScissors
    ROCK = 1
    PAPER = 2
    SCISSORS = 3
  end

  def initialize(file_name:)
    matches = []
    File.readlines(file_name, chomp: true).each do |line|
      matches << line.strip.split.map do |character|
        Day02Problem1.parse_character_to_selection(character: character)
      end
    end
    @matches = matches
  end

  def self.parse_character_to_selection(character:)
    result = nil
    if %w[A X].include?(character)
      result = RockPaperScissors::ROCK
    elsif %w[B Y].include?(character)
      result = RockPaperScissors::PAPER
    elsif %w[C Z].include?(character)
      result = RockPaperScissors::SCISSORS
    end
    result
  end

  def tally_score
    score = 0
    matches.each do |match|
      # Add score for the shape selection
      score += match[1]
      # Add score for the match outcome
      score += Day02Problem1.determine_match_score(shape_one: match[1], shape_two: match[0])
    end
    score
  end

  def self.determine_match_score(shape_one:, shape_two:)
    # If you wrap the 2 and -2 around to their opposite 1s, this gives -1 as loss, 0 as draw, and 1 as win
    match_difference = (shape_one - shape_two)
    match_difference = -1 if match_difference == 2
    match_difference = 1 if match_difference == -2
    # By shifting loss/draw/win value up by one value and multiplying by 3, we get the score from losing/drawing/winning
    (match_difference + 1) * 3
  end
end

problem = Day02Problem1.new(file_name: 'Day02/day02.in')
puts problem.tally_score
