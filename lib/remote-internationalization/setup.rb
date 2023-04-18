class RemoteInternationalization
  class Setup
    class << self
      attr_reader :adapter, :host

      def call(adapter:, host:)
        raise NotImplementedError unless adapter == :s3

        @adapter = adapter
        @host = host
      end
    end
  end
end
