# frozen_string_literal: true

# Class that defines various class methods to solve AoC D01P2
class Day01Problem2
  def self.find_max_calorie_count_array(file_name:)
    calorie_counts = count_calories_per_elf(file_name: file_name).sort.reverse

    sum_of_max_calories = 0
    3.times do |i|
      sum_of_max_calories += calorie_counts[i]
    end
    sum_of_max_calories
  end

  def self.count_calories_per_elf(file_name:)
    calorie_counts = []
    calorie_counts << 0
    File.readlines(file_name, chomp: true).each do |line|
      if line.strip == ''
        calorie_counts << 0
      else
        calorie_counts[-1] += line.to_i
      end
    end
    calorie_counts
  end
end

puts Day01Problem2.find_max_calorie_count_array(file_name: 'Day01/day01.in')
