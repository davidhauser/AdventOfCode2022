# frozen_string_literal: true

# Class that defines various class methods to solve AoC D02P2
class Day02Problem2
  attr_accessor :matches

  module RockPaperScissors
    ROCK = 1
    PAPER = 2
    SCISSORS = 3
  end

  module LoseDrawWin
    LOSE = -1
    DRAW = 0
    WIN = 1
  end

  def initialize(file_name:)
    matches = []
    File.readlines(file_name, chomp: true).each do |line|
      matches << line.strip.split.map do |character|
        Day02Problem2.parse_character_to_selection(character: character)
      end
    end
    @matches = matches
  end

  def self.parse_character_to_selection(character:)
    case character
    when 'A'
      RockPaperScissors::ROCK
    when 'B'
      RockPaperScissors::PAPER
    when 'C'
      RockPaperScissors::SCISSORS
    when 'X'
      LoseDrawWin::LOSE
    when 'Y'
      LoseDrawWin::DRAW
    when 'Z'
      LoseDrawWin::WIN
    else
      throw Exception
    end
  end

  def tally_score
    score = 0
    matches.each do |match|
      # Add score for the shape selection
      score += Day02Problem2.determine_our_move(match: match)
      # Add score for the match outcome
      score += (match[1] + 1) * 3
    end
    score
  end

  def self.determine_our_move(match:)
    our_move = match[0] + match[1]
    our_move = 1 if our_move == 4
    our_move = 3 if our_move.zero?
    our_move
  end
end

problem = Day02Problem2.new(file_name: 'Day02/day02.in')
puts problem.tally_score
