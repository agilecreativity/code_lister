require 'thor'
require 'agile_utils'
require_relative 'core_ext/hash'
module CodeLister
  class CLI < Thor
    desc "find", "List files by extensions, patterns, and simple criteria"
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::EXTS
    method_option *AgileUtils::Options::NON_EXTS
    method_option *AgileUtils::Options::INC_WORDS
    method_option *AgileUtils::Options::EXC_WORDS
    method_option *AgileUtils::Options::IGNORE_CASE
    method_option *AgileUtils::Options::RECURSIVE
    method_option *AgileUtils::Options::VERSION
    def find
      opts = options.symbolize_keys
      if opts[:version]
        puts "You are using CodeLister Version #{CodeLister::VERSION}"
        exit
      end
      CodeLister::Main.run(opts)
    end

    # Note: we don't use help so that we can run :r !./bin/code_lister help find
    # to see the update help if we have to without commenting out
    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
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
      EOS
    end

    default_task :usage
  end
end
