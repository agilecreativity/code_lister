module CodeLister
  CustomError = Class.new(StandardError)
  class << self
    # List files base on some extension
    def files(args = {})
      opts = {
        base_dir: Dir.pwd,
        recursive: false,
        exts: [],
        non_exts: []
      }.merge(args)

      base_dir = opts[:base_dir]
      raise CustomError, "The directory #{base_dir} is not valid or or not readable!" unless File.exists?(base_dir)

      wildcard = opts[:recursive] ? '**' : ''
      exts     = opts[:exts]
      non_exts = opts[:non_exts]

      file_with_extension    = Dir.glob(File.join(base_dir, wildcard, "*.{#{exts.join(",")}}"))
      file_with_no_extension = no_extension_files(base_dir, wildcard, non_exts)

      # combine the result
      (file_with_extension + file_with_no_extension).sort
    end

    # Filter out the list based on given list of words
    def filter(file_list, args = {})
      opts = {
        inc_words: [],
        exc_words: [],
        ignore_case: true
      }.merge(args)

      take_any!(file_list, opts)
      drop_any!(file_list, opts)

      file_list
    end

    private

    # List files that do not have the extension
    #
    # @return list of files that does not have any extension
    def no_extension_files(base_dir, wildcard, non_exts = [])
      list = []
      unless non_exts.empty?
        list = Dir.glob(File.join(base_dir, wildcard, "{#{non_exts.join(',')}}"))
      end
      list
    end

    def take_any!(file_list, args = {})
      words = args[:inc_words]
      ignore_case = args[:ignore_case]

      unless words.empty?
        file_list.select! do |file|
          matched_any?(words, file, ignore_case)
        end
      end

      file_list
    end

    def drop_any!(file_list, args = {})
      words = args[:exc_words]
      ignore_case = args[:ignore_case]
      unless words.empty?
        file_list.delete_if do |file|
          matched_any?(words, file, ignore_case)
        end
      end
      file_list
    end

    def matched_any?(words, file, ignore_case)
      words.any? { |word| matched?(ignore_case, word, file) }
    end

    def matched?(ignore_case, word, file)
      if ignore_case
        /#{word}/i =~ File.basename(file)
      else
        /#{word}/  =~ File.basename(file)
      end
    end

  end
end
