# frozen_string_literal: true

# Class that defines various class methods to solve AoC D05P2
class Day05Problem1
  attr_accessor :stacks

  def initialize(file_name:)
    @stacks = Day05Problem1.get_stacks(file_name: file_name)
  end

  def self.get_stacks(file_name:)
    parse_stacks(stack_lines: isolate_stacks(file_name: file_name))
  end

  def self.isolate_stacks(file_name:)
    stack_lines = []
    File.readlines(file_name, chomp: true).each do |line|
      stack_lines << line
      break if line.start_with?(' 1')
    end
    stack_lines
  end

  def self.parse_stacks(stack_lines:)
    stacks = []
    stack_lines.reverse.each do |line|
      if line.start_with?(' 1')
        stacks = Array.new(line.strip[-1].to_i) { [] }
      else
        line[1...-1].chars.each_with_index do |char, index|
          next unless char != ' ' && (index % 4).zero?

          stacks[index / 4].push(char)
        end
      end
    end
    stacks
  end

  def run_operations(file_name:)
    File.readlines(file_name).each do |line|
      next unless line.start_with?('m')

      command_values = line.match(/\D+(\d+)\D+(\d+)\D+(\d+)/).captures.map(&:to_i)
      from_stack = command_values[1] - 1
      to_stack = command_values[2] - 1
      number_to_move = command_values[0] < stacks[from_stack].length ? command_values[0] : stacks[from_stack].length
      values_to_move = stacks[from_stack][-number_to_move..]
      stacks[from_stack] = stacks[from_stack][(0...-number_to_move)]
      stacks[to_stack].concat(values_to_move) if values_to_move
    end
  end

  def to_s
    stacks.inject(String.new) { |result, stack| "#{result}#{stack}\n" }
  end

  def end_message
    stacks.inject(String.new) { |result, stack| "#{result}#{stack[-1]}" }
  end
end

file_name = 'Day05/day05.in'
problem = Day05Problem1.new(file_name: file_name)
problem.run_operations(file_name: file_name)
puts problem.end_message
