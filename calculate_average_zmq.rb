#!/usr/bin/env ruby --yjit
# Run with: time pv --rate --average-rate --progress measurements.txt | ./calculate_average_zmq.rb > agg.txt

require 'English'
require 'bundler/inline'

gemfile do
  gem 'timeout'
  gem 'async'
  gem 'cztop'
end

WORKERS         = 16
CHUNK_SIZE      = 2**20 # 1 MiB
MAP_ENDPOINT    = "ipc:///tmp/1brc.map.#$PROCESS_ID"
REDUCE_ENDPOINT = "ipc:///tmp/1brc.reduce.#$PROCESS_ID"

City = Struct.new(:min, :tot, :max, :n)

def city_hash
  Hash.new do |h,k|
    h[k] = City.new Float::INFINITY, 0, -Float::INFINITY, 0
  end
end

warn "main: #$PROCESS_ID"
worker_pids = WORKERS.times.map do |worker_id|
  fork do
    warn "worker #{worker_id}: #$PROCESS_ID"
    Process.setproctitle("#$0: worker #%d" % worker_id)
    pull_socket = CZTop::Socket::PULL.new
    push_socket = CZTop::Socket::PUSH.new

    pull_socket.connect MAP_ENDPOINT
    push_socket.connect REDUCE_ENDPOINT

    while true
      chunk  = pull_socket.receive.to_a.first
      cities = city_hash

      chunk.each_line do |line|
        name, val = line.split(";", 2)
        city      = cities[name]
        city.n   += 1
        val       = Float val
        city.min  = val if val < city.min
        city.max  = val if val > city.max
        city.tot += val
      end

      cities.default_proc = nil # make dumpable
      push_socket << Marshal.dump(cities)
    end
  end
end


at_exit do
  Timeout.timeout 1 do
    warn "main: terminating workers: #{worker_pids}"
    Process.kill(:TERM, *worker_pids)
    Process.waitall
  end
rescue Interrupt, Timeout::Error
  worker_pids.each do |pid|
    Process.kill(:KILL, pid)
  rescue SystemCallError
    # already dead
  else
    warn "main: killed worker #{pid}"
  end
end


Async do |task|
  all_chunks_sent = false
  nchunks         = 0

  task.async annotation: 'map' do
    push_socket = CZTop::Socket::PUSH.new
    push_socket.bind MAP_ENDPOINT

    chunk = ''

    until STDIN.eof?
      STDIN.read CHUNK_SIZE, chunk # ensures UTF-8
      # ensure we're on a line boundary
      chunk += STDIN.readline unless STDIN.eof?

      push_socket << chunk
      nchunks += 1
    end

    all_chunks_sent = true
    warn "main: all chunks sent to workers"
  end

  task.async annotation: 'reduce' do
    results     = city_hash
    pull_socket = CZTop::Socket::PULL.new
    pull_socket.bind REDUCE_ENDPOINT

    until all_chunks_sent && nchunks.zero?
      cities = Marshal.load pull_socket.receive.to_a.first

      results.merge! cities do |name, left, right|
        left.min  = right.min if right.min < left.min
        left.max  = right.max if right.max > left.max
        left.tot += right.tot
        left.n   += right.n
        left
      end

      nchunks -= 1
    end

    warn "main: sorting and printing ..."
    results.sort_by(&:first).each do |name, city|
      puts format("%s=%.1f/%.1f/%.1f", name, city.min, city.tot / city.n, city.max)
    end
  end
end

