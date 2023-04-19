module InitializationHelpers
  def setup_and_init!
    RemoteInternationalization::Setup.call(
      adapter: RemoteInternationalization::Adapters::S3.new(
        client: Aws::S3::Client.new(
          region: 'eu-west-1',
          endpoint: 'http://localhost:9080',
          access_key_id: 'DEV-ACCESSKEYID',
          secret_access_key: 'DEV-SECRETACCESSKEY',
          force_path_style: true
        ),
        bucket: 'locale-storage-dev'
      ),
      fallback_path: 'spec/examples/local/',
      download_to_path: 'tmp/locales/'
    )

    RemoteInternationalization::Initialize.call
  end
end
