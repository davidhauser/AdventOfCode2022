# frozen_string_literal: true

# Class that defines various class methods to solve AoC D04P2
class Day04Problem2
  def self.count_assignment_overlaps(file_name:)
    number_of_overlaps = 0
    File.readlines(file_name, chomp: true).each do |line|
      group_assignment = line.strip.split(',')
      number_of_overlaps += 1 if assignment_contains_overlap?(group_assignment: group_assignment)
    end
    number_of_overlaps
  end

  def self.assignment_contains_overlap?(group_assignment:)
    first_elf_sectors = group_assignment[0].split('-').map(&:to_i)
    second_elf_sectors = group_assignment[1].split('-').map(&:to_i)
    (first_elf_sectors.first >= second_elf_sectors.first || first_elf_sectors.last >= second_elf_sectors.first) &&
      (first_elf_sectors.first <= second_elf_sectors.last || first_elf_sectors.last <= second_elf_sectors.last)
  end
end

puts Day04Problem2.count_assignment_overlaps(file_name: 'Day04/day04.in')
