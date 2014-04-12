module CodeLister

  CustomError = Class.new(StandardError)

  class << self

    # List files base on some extension
    def files(args = {})
      opts = {
        base_dir: Dir.pwd,
        recursive: false,
        exts: [],
      }.merge(args)

      base_dir = opts[:base_dir]
      raise CustomError, "The directory #{base_dir} is not valid or or not readable!" unless File.exists?(base_dir)
      wildcard = opts[:recursive] ? '**' : ''
      exts = opts[:exts]
      patterns = File.join(base_dir, wildcard, "*.{#{exts.join(",")}}")

      Dir.glob(patterns).sort
    end

    # Filter out the list based on given list of words
    def filter(file_list, args = {})
      opts = {
        inc_words: [],
        exc_words: []
      }.merge(args)

      inc_words = opts[:inc_words]
      exc_words = opts[:exc_words]

      take_any!(file_list, inc_words)
      drop_any!(file_list, exc_words)

      file_list
    end

    private

    def take_any!(file_list, words)
      # need to take only the filename
      file_list.select! { |f| words.any? { |w| /#{w}/ =~ File.basename(f) } } unless words.empty?
      file_list
    end

    def drop_any!(file_list, words)
      file_list.delete_if { |f| words.any? { |w| /#{w}/ =~ File.basename(f) } } unless words.empty?
      file_list
    end

  end
end
