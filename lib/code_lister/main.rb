module CodeLister
  class Main
    class << self

      def run(options = {})
        args = default_options.merge(options)

        files = CodeLister.files(args)

        # Now filter out the list if any
        inc_words = args.fetch(:inc_words, [])
        exc_words = args.fetch(:exc_words, [])

        files = CodeLister.filter(files, inc_words: inc_words,
                                         exc_words: exc_words)

        # Note: for now just print out the list of files
        puts files

        files
      end

      private

      def default_options
        options = {
          base_dir: Dir.pwd,
          recursive: false,
          ignore_case: true,
          inc_words: [],
          exc_words: [],
          exts: [],
          non_exts: []
        }
      end
    end
  end
end
