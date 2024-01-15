# https://stackoverflow.com/questions/16159370/ruby-hash-default-value-behavior

stations = Hash.new {|hsh, key| hsh[key] = [] }

STDIN.each_line do |line|
  location, temperature = line.chomp.split(';')

  stations[location] << temperature.to_f
end

stations_aggregated = stations.transform_values do |measurements|
  min, max = measurements.minmax
  avg = measurements.sum / measurements.size

  [min, avg, max]
end

stations_aggregated.sort.map do |station, (min, avg, max)|
  puts format('%s=%.1f/%.1f/%.1f', station, min, avg, max)
end