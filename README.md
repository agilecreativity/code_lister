## code_lister

[![Gem Version](https://badge.fury.io/rb/code_lister.svg)](http://badge.fury.io/rb/code_lister)

This is the simple gem to search/filter the files based on simple criteria.
It provides the functionality similar to subset of `find` command in Linux/Unix system.

Initially it was part of my internal project. I extracted this out as a gem so
that I can re-use it in other project. I hope you will find it useful.

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
  code_lister find

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result if any
  -x, [--exc-words=one two three]          # List of words to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -v, [--version], [--no-version]          # Display version information

List files by extensions, patterns, and simple criteria
```

Example Usage:

- Find all java and ruby files in a given directory

e.g.

```ruby

# find all files that ends with '*.java' or '*.rb' in a given directory
#
# ./bin/code_lister find -b spec/fixtures/ -e rb java

spec/fixtures/demo1.xxx.rb
spec/fixtures/demo1.yyy.rb
spec/fixtures/demo2.xxx.rb
spec/fixtures/demo2.yyy.rb
spec/fixtures/java/demo3.xxx.java
spec/fixtures/java/demo3.yyy.java
spec/fixtures/java/demo4.xxx.java
spec/fixtures/java/demo4.yyy.java
```

- Find all java java and ruby files but include only the files that contain the word `xxx`

```ruby
# ./bin/code_lister find -b spec/fixtures/ -e rb java -n xxx
spec/fixtures/demo1.xxx.rb
spec/fixtures/demo2.xxx.rb
spec/fixtures/java/demo3.xxx.java
spec/fixtures/java/demo4.xxx.java

```

- Same as previous step, but filter out result that contain the word `demo3` or `demo4`

```ruby
# ./bin/code_lister find -b spec/fixtures/ -e rb java -n xxx -x demo3 demo4
spec/fixtures/demo1.xxx.rb
spec/fixtures/demo2.xxx.rb
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
bundle
rake -T

# Play around with it using Pry
rake pry

# Or play around with it using IRB
rake irb
```

From inside `Pry` or `IRB`

```ruby
include CodeLister

# To search for everything that ends in '*.java' and '*.rb" recursively
list1 = CodeLister.files(base_dir: "spec/fixtures", exts: %w(rb java), recursive: true)
puts list1

# To filter out the result list
list2 = CodeLister.filter(list1, inc_words: %w(final complete), exc_words: %w(demo test))
```

### Disclaimers

This is still work in progress. I may make several adjustment to the API and thus I might break
the compatibility as the result. Please let me know if you find any problem. Pull request is
always welcome.

### Changelogs

#### 0.0.4

- Add `ignore-case` option
- Use `-n' for `--include-words` and use `-i` for `--ignore-case`.
- Make the `--recursive` the default option
- Make the `--ignore-case` the default option

#### 0.0.3

- Update README.md to include better sample usage, and misc cleanup.

#### 0.0.2

- initial release

## Contributing

1. Fork it ( http://github.com/<my-github-username>/code_lister/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
