module CodeLister
  class CLI < Thor
    # rubocop:disable AmbiguousOperator, LineLength
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
      opts = options.deep_symbolize_keys
      if opts[:version]
        puts "You are using CodeLister Version #{CodeLister::VERSION}"
        exit
      end
      CodeLister::Main.run(opts)
    end

    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
Usage:
  code_lister

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: . (current directory)
  -e, [--exts=one two three]               # List of extensions to search for
  -f, [--non-exts=one two three]           # List of files without extension to search for
  -n, [--inc-words=one two three]          # List of words in the filename to be included with the result if any
  -x, [--exc-words=one two three]          # List of words in the filename to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Ignore the case in the input filename
                                           # Default: --ignore_case
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: --recursive
  -v, [--version], [--no-version]          # Display version information

List files by extensions, patterns, and simple criteria
      EOS
    end
    # rubocop:enable AmbiguousOperator, LineLength

    default_task :usage
  end
end
