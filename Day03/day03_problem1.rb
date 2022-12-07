# frozen_string_literal: true

# Class that defines various class methods to solve AoC D03P1
class Day03Problem1
  UPPER_CASE_CHARS = ('A'..'Z').to_a.freeze
  LOWER_CASE_CHARS = ('a'..'z').to_a.freeze

  attr_accessor :rucksacks

  def initialize(file_name:)
    @rucksacks = Day03Problem1.read_file_to_rucksacks(file_name: file_name)
  end

  def self.read_file_to_rucksacks(file_name:)
    rucksacks = []
    File.readlines(file_name, chomp: true).each do |line|
      stripped_line = line.strip
      line_split = stripped_line.length / 2
      rucksack = []
      rucksack << stripped_line[0...line_split]
      rucksack << stripped_line[line_split..]
      rucksacks << rucksack
    end
    rucksacks
  end

  def sum_priority_of_dup_items
    duplicate_items = []
    rucksacks.each do |rucksack|
      left_pocket_of_items = rucksack[0].chars
      right_pocket_of_items = rucksack[1].chars
      rucksack_duplicate_items = left_pocket_of_items.select { |item| right_pocket_of_items.include?(item) }
      duplicate_items << rucksack_duplicate_items.uniq
    end
    priorities_of_duplicate_items =
      duplicate_items.flatten.map { |duplicate_item| Day03Problem1priority_for_item(item: duplicate_item) }
    priorities_of_duplicate_items.inject(:+)
  end

  def self.priority_for_item(item:)
    if UPPER_CASE_CHARS.include?(item)
      item.ord - 'A'.ord + 27
    elsif LOWER_CASE_CHARS.include?(item)
      item.ord - 'a'.ord + 1
    end
  end
end

problem = Day03Problem1.new(file_name: 'Day03/day03.in')
puts problem.sum_priority_of_dup_items
