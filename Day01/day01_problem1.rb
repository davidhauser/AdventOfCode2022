# frozen_string_literal: true

# Class that defines various class methods to solve AoC D01P1
class Day01Problem1
  def self.find_max_calorie_count_array(file_name:)
    calorie_counts = count_calories_per_elf(file_name: file_name)

    max_calories = 0
    calorie_counts.each do |calorie_count|
      max_calories = calorie_count if calorie_count > max_calories
    end
    max_calories
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

  def self.find_max_calorie_count(file_name:)
    max_calories = 0
    current_calories = 0
    File.readlines(file_name, chomp: true).each do |line|
      if line.strip == ''
        max_calories = current_calories if current_calories > max_calories
        current_calories = 0
      else
        current_calories += line.to_i
      end
    end
    max_calories
  end
end

puts Day01Problem1.find_max_calorie_count_array(file_name: 'Day01/day01.in')
