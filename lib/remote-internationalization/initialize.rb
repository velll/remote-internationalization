class RemoteInternationalization
  module Initialize
    module_function

    extend RemoteInternationalization::Logger

    def call
      load!

      logger.info("RemoteInternationalization initialized with default locale: #{RemoteInternationalization.default_locale}")
    end

    def load!
      I18n.load_path = PrepareFiles.call
    end
  end
end
