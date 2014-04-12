require 'thor'
require_relative 'core_ext/hash'
module CodeLister
  class CLI < Thor

    desc "find", "List files by extension, patterns, and other criteria"

    method_option :base_dir,
                  aliases: "-b",
                  desc: "Base directory",
                  default: Dir.pwd

    method_option :exts,
                  aliases: "-e",
                  desc: "List of extensions to search for",
                  type: :array,
                  default: %w(rb)

    method_option :inc_words,
                  aliases: "-i",
                  desc: "List of words to be included in the result if any",
                  type: :array,
                  default: []

    method_option :exc_words,
                  aliases: "-x",
                  desc: "List of words to be excluded from the result if any",
                  type: :array,
                  default: []

    method_option :recursive,
                  aliases: "-r",
                  desc: "Search for files recursively",
                  type: :boolean,
                  default: false

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
  -b, [--base-dir=BASE_DIR]            # Base directory
                                       # Default: /Users/agilecreativity/Dropbox/spikes/code_explorer
  -e, [--exts=one two three]           # List of extensions to search for
                                       # Default: ["rb"]
  -i, [--inc-words=one two three]      # List of words to be included in the result if any
  -x, [--exc-words=one two three]      # List of words to be excluded from the result if any
  -r, [--recursive], [--no-recursive]  # Search for files recursively
  -v, [--version], [--no-version]      # Display version information

List files based on select multiple criteria
      EOS
    end

    default_task :usage
  end
end
