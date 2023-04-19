class RemoteInternationalization
  class Setup
    class << self
      attr_reader :adapter, :host, :fallback_path, :download_to_path, :logger

      def call(adapter:, fallback_path:, download_to_path:, logger: ::Logger.new($stdout))
        raise NotImplementedError unless adapter.is_a? Adapters::S3

        @adapter = adapter
        @host = host
        @fallback_path = File.expand_path(fallback_path)
        @download_to_path = File.expand_path(download_to_path)
        @logger = logger
      end
    end
  end
end
