# frozen_string_literal: true

# Class that defines various class methods to solve AoC D03P2
class Day03Problem2
  UPPER_CASE_CHARS = ('A'..'Z').to_a.freeze
  LOWER_CASE_CHARS = ('a'..'z').to_a.freeze

  attr_accessor :badges

  def initialize(file_name:)
    badges = []
    rucksack_group = []
    group_ticker = 0
    File.readlines(file_name, chomp: true).each do |line|
      rucksack_group << line
      group_ticker += 1
      next unless group_ticker == 3

      badges << Day03Problem2.find_rucksack_group_badge(rucksack_group: rucksack_group)
      rucksack_group = []
      group_ticker = 0
    end
    @badges = badges
  end

  def self.find_rucksack_group_badge(rucksack_group:)
    rucksack_group[0].chars.each do |char|
      return char if rucksack_group[1].include?(char) && rucksack_group[2].include?(char)
    end
  end

  def sum_priority_of_badges
    priority_of_badges = badges.map { |badge| Day03Problem2.priority_for_item(item: badge) }
    priority_of_badges.inject(:+)
  end

  def self.priority_for_item(item:)
    if UPPER_CASE_CHARS.include?(item)
      item.ord - 'A'.ord + 27
    elsif LOWER_CASE_CHARS.include?(item)
      item.ord - 'a'.ord + 1
    end
  end
end

problem = Day03Problem2.new(file_name: 'Day03/day03.in')
puts problem.sum_priority_of_badges