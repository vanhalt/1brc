# https://stackoverflow.com/questions/16159370/ruby-hash-default-value-behavior

measurements_file = File.open('measurements.txt', 'r')

stations = Hash.new {|hsh, key| hsh[key] = [] }

measurements_file.each do |line|
  location, temperature = line.chomp.split(';')

  stations[location] << temperature.to_f
end

stations.each do |station, measurements|
  puts "#{station} - min: #{measurements.first}, max: #{measurements.first}, avg: #{measurements.first}" if measurements.size == 1 && next

  measurements.sort!

  min = measurements.first
  max = measurements.last
  avg = measurements.sum(0.0) / measurements.size

  puts "#{station} - min: #{min}, max: #{max}, avg: #{avg}"
end