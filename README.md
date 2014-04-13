## code_lister

This is the simple gem to search/filter the files based on simple criteria.
It provides the functionality similar to `find` command in Linux/Unix system.

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

Usage:

```
Usage:
  code_lister find

Options:
  -b, [--base-dir=BASE_DIR]            # Base directory
                                       # Default: /Users/agilecreativity/Dropbox/spikes/code_explorer
  -e, [--exts=one two three]           # List of extensions to search for
                                       # Default: ["rb"]
  -i, [--inc-words=one two three]      # List of words to be included in the result if any
  -x, [--exc-words=one two three]      # List of words to be excluded from the result if any
  -r, [--recursive], [--no-recursive]  # Search for files recursively
  -v, [--version], [--no-version]      # Display version information

List files based on select multiple criteria
```

#### Using as ruby library

```ruby
require 'code_lister'
include CodeLister
# To search for everything that ends in '*.java' and '*.rb" recursively
list1 = CodeLister.files(base_dir: "spec/fixtures", exts: %w(rb java), recursive: true)
puts list1
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
#include CodeLister
# To search for everything that ends in '*.java' and '*.rb" recursively
list1 = CodeLister.files(base_dir: "spec/fixtures", exts: %w(rb java), recursive: true)
puts list1

# To filter out the result list
list2 = CodeLister.filter(list1, inc_words: %w(final complete), exc_words: %w(demo test))
```
### Changelogs

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
