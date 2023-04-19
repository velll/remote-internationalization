class RemoteInternationalization
  class LocaleFile
    def initialize(file_path)
      @pathname = Pathname.new(file_path)
    end

    def basename
      @pathname.basename.to_s
    end

    def original_path
      @pathname.to_s
    end
  end
end
