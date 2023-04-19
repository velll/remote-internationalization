class RemoteInternationalization
  module Initialize
    extend self
    extend RemoteInternationalization::Logger

    def call
      I18n.load_path = Setup.fallback_path

      logger.info("RemoteInternationalization initialized with default locale: #{RemoteInternationalization.default_locale}")
      RemoteInternationalization.new
    end
  end
end
