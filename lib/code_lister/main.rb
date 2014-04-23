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
        puts files
        files
      end

      private

      def default_options
        { base_dir: Dir.pwd,
          recursive: true,
          ignore_case: true,
          inc_words: [],
          exc_words: [],
          exts: [],
          non_exts: [] }
      end
    end
  end
end
