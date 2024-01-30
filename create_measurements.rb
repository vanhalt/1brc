#! /usr/bin/env ruby

require_relative './stations/stations'

MEASUREMENTS_FILE_NAME = 'measurements.txt'

begin
  iterations = Integer ARGV.first
rescue
  abort "Usage: #$0 <INT>"
end


stations = Stations.ary

File.open(MEASUREMENTS_FILE_NAME, 'w') do |f|
  iterations.times do
    station = stations.sample
    f.puts "#{station.location};#{station.measurement}"
  end
end