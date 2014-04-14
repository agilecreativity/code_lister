require 'thor'
require_relative 'core_ext/hash'

module CodeLister
  class CLI < Thor

    desc "find", "List files by extensions, patterns, and simple criteria"

    method_option :base_dir,
                  aliases: "-b",
                  desc: "Base directory",
                  default: Dir.pwd

    method_option :exts,
                  aliases: "-e",
                  desc: "List of extensions to search for",
                  type: :array,
                  default: []

    method_option :inc_words,
                  aliases: "-n",
                  desc: "List of words to be included in the result if any",
                  type: :array,
                  default: []

    method_option :exc_words,
                  aliases: "-x",
                  desc: "List of words to be excluded from the result if any",
                  type: :array,
                  default: []

    method_option :ignore_case,
                  aliases: "-i",
                  desc: "Match case insensitively",
                  type: :boolean,
                  default: true

    method_option :recursive,
                  aliases: "-r",
                  desc: "Search for files recursively",
                  type: :boolean,
                  default: true

    method_option :version,
                  aliases: "-v",
                  desc: "Display version information",
                  type: :boolean,
                  default: false
    def find

      if options[:version]
        puts "You are using CodeLister Version #{CodeLister::VERSION}"
        exit
      end

      CodeLister::Main.run(options.symbolize_keys)
    end

    # Note: we don't use help so that we can run :r !./bin/code_lister help find
    # to see the update help if we have to without commenting out
    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
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
      EOS
    end

    default_task :usage
  end
end
