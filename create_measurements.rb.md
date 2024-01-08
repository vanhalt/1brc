# /usr/bin/time


### 20 rows

```
/usr/bin/time -h -l -p ./create_measurements.rb 20
Ruby 3.2.2
real 0.18
user 0.03
sys 0.02
            30785536  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
                3457  page reclaims
                  13  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                   0  signals received
                 123  voluntary context switches
                  89  involuntary context switches
           494556026  instructions retired
           165187953  cycles elapsed
            26084672  peak memory footprint
```

### 1_000_000 rows

```
/usr/bin/time -h -l -p ./create_measurements.rb 1000000
Ruby: 3.2.2
real 78.07
user 77.49
sys 0.47
            31014912  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
                3473  page reclaims
                  33  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                   0  signals received
                 125  voluntary context switches
                 731  involuntary context switches
       1413638737928  instructions retired
        267957995924  cycles elapsed
            26330496  peak memory footprint
```

### 10_000_000 rows

```
/usr/bin/time -h -l -p ./create_measurements.rb 10000000
Ruby: 3.2.2
real 1237.12
user 790.19
sys 6.78
            31522816  maximum resident set size
                   0  average shared memory size
                   0  average unshared data size
                   0  average unshared stack size
                3622  page reclaims
                  13  page faults
                   0  swaps
                   0  block input operations
                   0  block output operations
                   0  messages sent
                   0  messages received
                   0  signals received
                  12  voluntary context switches
              168410  involuntary context switches
      14135129236546  instructions retired
       2694245230796  cycles elapsed
            27985216  peak memory footprint
```

# Profiling

### 20 rows JIT enabled

```
bundle exec ruby-prof create_measurements.rb -- 20
Ruby: 3.2.2
Measure Mode: wall_time
Thread ID: 1380
Fiber ID: 1360
Total: 0.009493
Sort by: self_time

 %self      total      self      wait     child     calls  name                           location
 28.12      0.005     0.003     0.000     0.002    16520   Class#new
 25.90      0.002     0.002     0.000     0.000    16520   WeatherStation#initialize      /Users/rperez1/Documents/mycode/1brc_ruby/weather_station.rb:8
 16.96      0.007     0.002     0.000     0.005       40   <Class::Stations>#ary          /Users/rperez1/Documents/mycode/1brc_ruby/stations.rb:4
 13.38      0.002     0.001     0.000     0.001        2  *Kernel#require_relative
  9.67      0.001     0.001     0.000     0.000        2  *Kernel#gem_original_require
  3.17      0.009     0.000     0.000     0.009        1   Kernel#load
  0.80      0.000     0.000     0.000     0.000        1   File#initialize
  0.28      0.007     0.000     0.000     0.007        1   Integer#times
  0.27      0.000     0.000     0.000     0.000       41   <Class::Random>#urandom
  0.21      0.000     0.000     0.000     0.000       40   <Module::SecureRandom>#gen_random /Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/3.2.0/securerandom.rb:64
  0.14      0.000     0.000     0.000     0.000       21   IO#write
  0.14      0.000     0.000     0.000     0.000       20   WeatherStation#measurement     /Users/rperez1/Documents/mycode/1brc_ruby/weather_station.rb:14
  0.12      0.000     0.000     0.000     0.000       20   Float#to_s
  0.12      0.000     0.000     0.000     0.000       40   Random::Formatter#random_number
  0.09      0.000     0.000     0.000     0.000       40   <Module::SecureRandom>#bytes   /Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/3.2.0/securerandom.rb:43
  0.06      0.000     0.000     0.000     0.000       21   IO#puts
  0.05      0.000     0.000     0.000     0.000       10   IO#set_encoding
  0.04      0.000     0.000     0.000     0.000        3   Range#each
  0.04      0.000     0.000     0.000     0.000       40   Kernel#freeze
  0.04      0.000     0.000     0.000     0.000       20   Float#round
  0.03      0.000     0.000     0.000     0.000       40   String#length
  0.03      0.000     0.000     0.000     0.000       40   Integer#==
  0.03      0.009     0.000     0.000     0.009        1   RubyProf::Cmd#run              /Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/gems/3.2.0/gems/ruby-prof-1.7.0/bin/ruby-prof:303
  0.02      0.000     0.000     0.000     0.000       20   Array#size
  0.02      0.001     0.000     0.000     0.001        2  *Kernel#require                 <internal:/Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:36
  0.02      0.000     0.000     0.000     0.000       20   WeatherStation#location
  0.02      0.000     0.000     0.000     0.000       20   Float#*
  0.02      0.000     0.000     0.000     0.000       20   Float#+
  0.02      0.000     0.000     0.000     0.000        1   Module#attr_reader
  0.02      0.000     0.000     0.000     0.000       20   Array#[]
  0.02      0.000     0.000     0.000     0.000        3   Range#to_a
  0.02      0.000     0.000     0.000     0.000       20   WeatherStation#mean_temperature
  0.02      0.000     0.000     0.000     0.000       12   Module#method_added
  0.02      0.000     0.000     0.000     0.000        1   Module#extend_object
  0.02      0.000     0.000     0.000     0.000        6   Module#const_added
  0.01      0.000     0.000     0.000     0.000        1   Kernel#puts
  0.01      0.000     0.000     0.000     0.000        3   Module#private
  0.01      0.000     0.000     0.000     0.000        2   <Module::Gem>#discover_gems_on_require
  0.01      0.000     0.000     0.000     0.000        3   Enumerable#to_a
  0.01      0.000     0.000     0.000     0.000        1   <Class::IO>#open
  0.01      0.000     0.000     0.000     0.000        3   String#<=>
  0.01      0.000     0.000     0.000     0.000        1   Kernel#extend
  0.01      0.000     0.000     0.000     0.000        5   BasicObject#singleton_method_added
  0.00      0.000     0.000     0.000     0.000        1   String#to_i
  0.00      0.000     0.000     0.000     0.000        2   Class#inherited
  0.00      0.000     0.000     0.000     0.000        1   Module#public
  0.00      0.000     0.000     0.000     0.000        1   Array#first
  0.00      0.000     0.000     0.000     0.000        1   Module#extended
```

### 20 rows

```
Ruby: 3.2.2
Measure Mode: wall_time
Thread ID: 1380
Fiber ID: 1360
Total: 0.009167
Sort by: self_time

 %self      total      self      wait     child     calls  name                           location
 26.50      0.005     0.002     0.000     0.002    16520   Class#new
 25.69      0.002     0.002     0.000     0.000    16520   WeatherStation#initialize      /Users/rperez1/Documents/mycode/1brc_ruby/weather_station.rb:8
 17.90      0.006     0.002     0.000     0.005       40   <Class::Stations>#ary          /Users/rperez1/Documents/mycode/1brc_ruby/stations.rb:4
 13.42      0.002     0.001     0.000     0.001        2  *Kernel#require_relative
 10.22      0.001     0.001     0.000     0.000        2  *Kernel#gem_original_require
  2.87      0.000     0.000     0.000     0.000        1   File#initialize
  1.46      0.009     0.000     0.000     0.009        1   Kernel#load
  0.26      0.007     0.000     0.000     0.007        1   Integer#times
  0.21      0.000     0.000     0.000     0.000       40   <Module::SecureRandom>#gen_random /Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/3.2.0/securerandom.rb:64
  0.20      0.000     0.000     0.000     0.000       21   IO#write
  0.18      0.000     0.000     0.000     0.000       20   Float#to_s
  0.14      0.000     0.000     0.000     0.000       41   <Class::Random>#urandom
  0.11      0.000     0.000     0.000     0.000       20   WeatherStation#measurement     /Users/rperez1/Documents/mycode/1brc_ruby/weather_station.rb:14
  0.10      0.000     0.000     0.000     0.000       40   Random::Formatter#random_number
  0.09      0.000     0.000     0.000     0.000       40   <Module::SecureRandom>#bytes   /Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/3.2.0/securerandom.rb:43
  0.06      0.000     0.000     0.000     0.000       21   IO#puts
  0.06      0.000     0.000     0.000     0.000       10   IO#set_encoding
  0.04      0.000     0.000     0.000     0.000       40   Kernel#freeze
  0.04      0.000     0.000     0.000     0.000        3   Range#each
  0.03      0.000     0.000     0.000     0.000       20   Float#round
  0.03      0.000     0.000     0.000     0.000       40   String#length
  0.03      0.009     0.000     0.000     0.009        1   RubyProf::Cmd#run              /Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/gems/3.2.0/gems/ruby-prof-1.7.0/bin/ruby-prof:303
  0.03      0.000     0.000     0.000     0.000       40   Integer#==
  0.02      0.000     0.000     0.000     0.000       20   Float#*
  0.02      0.000     0.000     0.000     0.000       20   WeatherStation#location
  0.02      0.000     0.000     0.000     0.000       20   Array#size
  0.02      0.000     0.000     0.000     0.000       20   Array#[]
  0.02      0.000     0.000     0.000     0.000       20   Float#+
  0.02      0.001     0.000     0.000     0.001        2  *Kernel#require                 <internal:/Users/rperez1/.asdf/installs/ruby/3.2.2/lib/ruby/3.2.0/rubygems/core_ext/kernel_require.rb>:36
  0.02      0.000     0.000     0.000     0.000        1   Module#attr_reader
  0.02      0.000     0.000     0.000     0.000        2   <Module::Gem>#discover_gems_on_require
  0.02      0.000     0.000     0.000     0.000        6   Module#const_added
  0.02      0.000     0.000     0.000     0.000       20   WeatherStation#mean_temperature
  0.02      0.000     0.000     0.000     0.000       12   Module#method_added
  0.01      0.000     0.000     0.000     0.000        3   Range#to_a
  0.01      0.000     0.000     0.000     0.000        1   Module#extend_object
  0.01      0.000     0.000     0.000     0.000        1   Kernel#puts
  0.01      0.000     0.000     0.000     0.000        3   Module#private
  0.01      0.000     0.000     0.000     0.000        3   Enumerable#to_a
  0.01      0.000     0.000     0.000     0.000        1   <Class::IO>#open
  0.01      0.000     0.000     0.000     0.000        3   String#<=>
  0.01      0.000     0.000     0.000     0.000        5   BasicObject#singleton_method_added
  0.01      0.000     0.000     0.000     0.000        1   Kernel#extend
  0.01      0.000     0.000     0.000     0.000        1   String#to_i
  0.00      0.000     0.000     0.000     0.000        2   Class#inherited
  0.00      0.000     0.000     0.000     0.000        1   Module#public
  0.00      0.000     0.000     0.000     0.000        1   Array#first
  0.00      0.000     0.000     0.000     0.000        1   Module#extended
```