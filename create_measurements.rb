#! /usr/bin/env ruby

require_relative './stations/stations'

MEASUREMENTS_FILE_NAME = 'measurements.txt'

begin
  iterations = Integer ARGV.first
rescue
  abort "Usage: #$0 <INT>"
end

measurements_file = File.open(MEASUREMENTS_FILE_NAME, 'w')

iterations.times do
  stations_size = Stations.ary.size
  station = Stations.ary[SecureRandom.random_number(stations_size)]
  measurements_file.puts "#{station.location};#{station.measurement}"
end