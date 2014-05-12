## code_lister

[![Gem Version](https://badge.fury.io/rb/code_lister.svg)](http://badge.fury.io/rb/code_lister)
[![Dependency Status](https://gemnasium.com/agilecreativity/code_lister.png)](https://gemnasium.com/agilecreativity/code_lister)
[![Code Climate](https://codeclimate.com/github/agilecreativity/code_lister.png)](https://codeclimate.com/github/agilecreativity/code_lister)

Find/filter files based on simple criteria like `extension`, include/exclude some words in the name.
It provides the functionality similar to subset of `find | grep` command in Linux/Unix system.

Initially this was part of my internal project. I extracted this out as a gem so
that I can re-use it in other project.

Note: starting from version `0.1.0` this gem will follow the [Semantic Versioning] convention.

### Installation

Add this line to your application's Gemfile:

    gem 'code_lister'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install code_lister

### Usage

#### Using as CLI interface

List all pdf and epub files in the `/opts/downloads/` directory recursively

```sh
$code_lister find --base-dir /opt/downloads/ --exts pdf epub --recursive
```

Usage/Synopsis:

```
Usage:
  code_lister find [OPTIONS]

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -f, [--non-exts=one two three]           # List of extensions to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result
  -x, [--exc-words=one two three]          # List of words to be excluded from the result
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -v, [--version], [--no-version]          # Display version information

List files by extensions, patterns, and simple criteria
```

Example Usage:

- Find all java and ruby files in a given directory

```ruby

# find all files that ends with '*.java' or '*.rb' in a given directory
#
# ./bin/code_lister find -b spec/fixtures/ -e rb java

```
./demo1.xxx.rb
./demo1.yyy.rb
./demo2.xxx.rb
./demo2.yyy.rb
./java/demo3.xxx.java
./java/demo3.yyy.java
./java/demo4.xxx.java
./java/demo4.yyy.java
```

- Find all java java and ruby files but include only the files that contain the word `xxx`

```ruby
# ./bin/code_lister find -b spec/fixtures/ -e rb java -n xxx

./demo1.xxx.rb
./demo2.xxx.rb
./java/demo3.xxx.java
./java/demo4.xxx.java
```
- Same as previous step, but filter out result that contain the word `demo3` or `demo4`
```ruby
# ./bin/code_lister find -b spec/fixtures/ -e rb java -n xxx -x demo3 demo4
./demo1.xxx.rb
./demo2.xxx.rb
```

#### Using as ruby library

This is probably the proper way to utilize the library as the CLI only serve to
demonstrate purpose only.

Example of how you might use the library in your own project.

```ruby
require 'code_lister'
include CodeLister

# To search for everything that ends in '*.java' and '*.rb" recursively
file_list = CodeLister.files base_dir: "spec/fixtures",
                             exts: %w(rb java),
                             recursive: true
puts file_list

# To filter out the result you may do so with the `CodeLister.filter` method
new_list = CodeLister.filter(file_list, inc_words: %w(some list of word),
                                        exc_words: %w(other text to excluded),
                                        ignore_case: false)
```

### Development/Testing

```sh
git clone https://github.com/agilecreativity/code_lister.git
cd code_lister
bundle
rake -T

# Play around with it using Pry
rake pry

From inside `Pry`

```ruby
include CodeLister

# To search for everything that ends in '*.java' and '*.rb" recursively
list1 = CodeLister.files(base_dir: "spec/fixtures", exts: %w(rb java), recursive: true)
puts list1

# To filter out the result list
list2 = CodeLister.filter(list1, inc_words: %w(final complete), exc_words: %w(demo test))
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/code_lister/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[Semantic Versioning]: http://semver.org
