module CodeLister
  CustomError = Class.new(StandardError)
  class << self
    # Execute the command in the shell and extract the output to be used
    #
    # Example
    #
    # Use the file list from the 'find | grep' command
    #
    # 'find ~/Desktop/pdfkit -type f -iname "*.rb" | grep -v spec'
    #
    # @param [String] command the input command to be executed in the shell
    # @param [String] base_dir the starting directory
    # @return [Array<String>] file list or empty list if the shell command is not valid
    def files_from_command(command, base_dir = ".")
      files = AgileUtils::Helper.shell(command.split(" ")).split(/\n/)
      # Adapt the result and make sure that it starts with "./"
      # like the result from 'CodeLister.files()' method
      files.map! do |file|
        if base_dir
          if file =~ /^\./
            File.expand_path(file).gsub(File.expand_path(base_dir), ".")
          else
            File.expand_path(file).gsub(File.expand_path(base_dir), ".")
          end
        end
      end
      files.delete_if do |file|
        !File.exist?([
          File.expand_path(base_dir),
          file.gsub(/^\./, '')
        ].join(""))
      end
      files
    rescue RuntimeError => e
      # just return the empty list, if the user specified invalid command
      return []
    end

    # List files base on multiple simple criteria
    #
    # @param [Hash<Symbol>,<Object>] args argument hash
    # @option args [String]         :base_dir the starting directory
    # @option args [Boolean]        :recursive flag to indicate if the search will be done recursively
    # @option args [Array<String>]  :exts list of file extension to search for (without the dot)
    # @option args [Array<String>]  :non_exts list of file without any extension to search for
    # @return [Array<String>] the list of file based on the matching criteria
    def files(args = {})
      opts = {
        base_dir:  Dir.pwd,
        recursive: false,
        exts:      [],
        non_exts:  []
      }.merge(args)

      # always expand the path
      base_dir = File.expand_path(opts[:base_dir])
      fail CustomError, "The directory #{base_dir} is not valid or or not readable!" unless File.exist?(base_dir)

      wildcard = opts[:recursive] ? "**" : ""
      exts     = opts[:exts]
      non_exts = opts[:non_exts]

      files_with_extension    = Dir.glob(File.join(base_dir, wildcard, "*.{#{exts.join(",")}}"))
      files_without_extension = no_extension_files(base_dir, wildcard, non_exts)
      # remove the 'base_dir' with .
      files_with_extension.each { |f| f.gsub!(base_dir, ".") }
      files_without_extension.each { |f| f.gsub!(base_dir, ".") }
      # combine the result
      (files_with_extension + files_without_extension).sort
    end

    # Filter out the list based on simple criteria
    #
    # @param [Array<String>] file_list the input file list
    # @param [Hash<Symbol, Object>] args the option hash
    # @option args [Array<String>]  :inc_words list of words that must be match to be included in the result
    # @option args [Array<String>]  :exc_words list of words that will be excluded fromt the result
    # @option args [Boolean]        :ignore_case flag to indicate how the string comparision should be performed
    # @return [Array<String>] the original list with the result filtered
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
        list = Dir.glob(File.join(base_dir, wildcard, "{#{non_exts.join(",")}}"))
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
