class RemoteInternationalization
  class Setup
    class << self
      attr_reader :adapter, :host, :fallback_path, :logger

      def call(adapter:, host:, fallback_path:, logger: ::Logger.new(STDOUT))
        raise NotImplementedError unless adapter == :s3

        @adapter = adapter
        @host = host
        @fallback_path = Dir["#{File.expand_path(fallback_path)}/*.yml"]
        @logger = logger
      end
    end
  end
end
