# frozen_string_literal: true

def find_index_of_message_marker(data_stream:, num_unique_chars:)
  result = -1
  (num_unique_chars..data_stream.length).each do |end_index|
    next unless data_stream[((end_index - num_unique_chars)...end_index)]
                .chars.uniq.length == num_unique_chars

    result = end_index
    break
  end
  result
end

file_name = 'Day06/day06.in'
File.readlines(file_name, chomp: true).each do |line|
  puts find_index_of_message_marker(data_stream: line, num_unique_chars: 4)
  puts find_index_of_message_marker(data_stream: line, num_unique_chars: 14)
end
