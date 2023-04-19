# For every file in Setup#fallback_path try to download a remote copy
#   => Returns a list of file paths
#
# - Remote copies are stored at Setup#download_to_path
# - When a remote copy cannot be obtained, the local translation file
#   will be returned as a fallback measure
class RemoteInternationalization
  module PrepareFiles
    extend self
    extend Logger

    def call
      clear_dir(Setup.download_to_path)
      try_files(Setup.download_to_path)
    end

    private

    def clear_dir(dir)
      Pathname.new(dir).children.each(&:unlink)
    end

    def try_files(dir)
      local_translation_files.map do |file|
        logger.info "Processing #{file.basename}"

        if (remote_path = Setup.adapter.download(file.basename.to_s, dir))
          logger.info("Using remote copy of #{file.basename}")
          remote_path
        else
          logger.warn("Could not obtain remote copy of #{file.basename}. Falling back to a local copy")
          file.to_s
        end
      end
    end

    def local_translation_files
      files_in_dir(Setup.fallback_path).map do |file_path|
        Pathname.new(file_path)
      end
    end

    def files_in_dir(dir)
      Dir["#{File.expand_path(dir)}/*.yml"]
    end
  end
end
