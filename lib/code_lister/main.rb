module CodeLister
  class Main
    class << self

      def run(options = {})
        args = default_options.merge(options)

        files = CodeLister.files(args)

        ## Now filter out the list any?
        inc_words = args.fetch(:inc_words, [])
        exc_words = args.fetch(:exc_words, [])

        files = CodeLister.filter(files, inc_words: inc_words,
                                         exc_words: exc_words)
        # TODO: remove when done!
        puts files

        files
      end

      private

      def default_options
        options = {
          base_dir: Dir.pwd,
          recursive: false,
          inc_words: [],
          exc_words: [],
          exts: []
        }
      end
    end
  end
end
