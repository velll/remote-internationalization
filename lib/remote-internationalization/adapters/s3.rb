class RemoteInternationalization
  module Adapters
    class S3
      attr_reader :client, :bucket

      include Logger

      def initialize(client:, bucket:)
        @client = client
        @bucket = bucket
      end

      def download(key, target_dir)
        FileUtils.mkdir_p target_dir

        get_object(bucket, key, File.join(target_dir, key))
      end

      private

      def get_object(bucket, key, target_path)
        client.get_object(bucket:, key:, response_target: target_path)

        target_path
      rescue Aws::S3::Errors::ServiceError, Seahorse::Client::NetworkingError => e
        logger.error("Exception caught while downloading #{key}: #{e.message}")
        nil
      end
    end
  end
end
