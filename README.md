# The One Billion Row Challenge - Ruby Edition

Ruby edition of the [1BRC](https://github.com/gunnarmorling/1brc/tree/main) Java challenge.

I am using `asdf` to install ruby versions: 3.2.2 and 3.3.0

# Tools

### Gemfile

I included a profiler so you can tweak your implementation and create the fastest one!

```bash
bundle install

bundle exec ruby-prof create_measurements.rb -- 20
```

Note: initial usage for me was to create the `measurements.txt` file...

### time_measurements_creation

Bash script to output 5 times per ruby version its `time` execution...

```shell
# 200 iterations
# create_measurements.rb script outputs measurements.txt file

./time_measurements_creation 200 create_measurements.rb
```

### average_execution

Outputs metrics about the execution real time of the ruby versions...

```shell
./average_execution
```
