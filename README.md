# Remote Internationalization

A Ruby gem that builds on top of the i18n library
Supports fetching translation files via HTTP rather than just relying on local translation files

Falls back to local translation files in case of network issues while accessing the remote files 

# Dependencies

The gem uses `I18n` under the hood and the `aws-sdk-s3` client for downloading translations from S3 compatible storage.

# Initializing and Usage

The gem requires configuration and initializing, put it somewhere that runs on startup (e.g. `config/initializers`):

```ruby
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
    fallback_path: 'config/locales',
    download_to_path: 'tmp/locales/'
  )

  RemoteInternationalization::Initialize.call
```

`RemoteInternationalization` defines a short alias `RI`

After initializing call `t` for translating a key as usual:
```ruby
RI.t(:key)
```

Switch locales using the block form of `with_locale`
```ruby
RI.with_locale(:en) { RI.t(:key) }
```

### Adapter settings

Only S3 adapter is implemented at the moment (`RemoteInternationalization::Adapters::S3`). Please supply a working instance of `Aws::S3::Client`:
- if you are using the client SDK in your application, it's probably already configured
- `endpoint` and `force_path_style` are not relevant for S3, but may be needed for S3 compatible storage servers (like minio)

Other than an instance of a client please supply the bucket name. The library expects to find translation files *at the root* of the bucket (e.g. if you have a `config/locales/en.yml` localy, the library will expect to find `en.yml` in the bucket).

### Directories

`fallback_path` is used for two things:
  1. when the gem cannot fetch translation files from the remote storage, the files from `fallback_path` will be used instead
  1. the gem will only try to download the files that match the local files at `fallback_path` (so if you only have `en.yml` and `de.yml` at `fallback_path`, the gem will only try to download `en.yml` and `de.yml` from the bucket, and nothing else)

`download_to_path` is simply the directory where the gem will store the files it downloaded from the bucket

Check out the [sinatra example](/examples/sinatra) in /examples

# Server Side Requirements

The server should provide an S3 compatible interface for downloading files.

# Supported I18n functionality

1. Translating a key using the current locale: `RI.t(:key)`
1. Choosing the current locale with `RI.with_locale(:en) { RI.t(:key) }`

# End of Readme :) 

## Running tests

Tests rely on a running instance of minio. Good news is everything is packed in the `docker-compose.yml`
```bash
docker compose up
```

Tests are written with rspec
```bash
rspec
```
# Out of scope

Following are some thoughts on the take home task, and some more context on design decisions and the corners I have cut

These things would be great in production, but have to go since I'm short on time :)
Happy to explore any of these topics on an interview 

### Runtime

Updating translations during runtime is not supported: the translation files are being downloaded **once** while initializing the gem. There is nothing about it in the requirements, but I can imagine that this would be a massive sticking point in a real project. This has pretty big implications.
  1. Serving strings and reloading the files look like two very different workloads to me
  1. Downloading a fresh version of the file on every call to `t` is not really an option :)
  1. Looks like a good case for `Backend`s of `I18n`
  1. In a distributed system I would go with a key-value storage instead: multiple processes can access it, and reloading can be done separately (i.e. 'Inject a redis client -> Receive a caching/invalidating logic + support for distributed processes')

When do we need to download a new file? *(a case for S3 compatible storage)*
- We can fetch the hash (ETag) of the file at any time and compare it with the ETag of the file we have already downloaded.
- Polling would not be a massive problem (at the end of the day, we would be polling S3, S3 can handle it)
- S3 supports Event Notifications if we want to really have fun. Saving a new file (or a new version of an existing file) can trigger an event (e.g. a message to SQS), that we can process as we see fit. 

### I18n functionality

1. I limited support to  `I18n.with_locale` and `I18n.t` are supported.
1. Global state: `I18n` is configured once and has a global state. Since I'm using it directly, I'm closing the door to the scenario when `I18n` is used alongside with this gem. This is not supported.

### API exchange

Rethinking of the exchange with the server. I am not sure that fetching entire files from the server and working on that level is a good strategy.

Another strategy would be to build a server that accepts a **key** and replies with a **string** (with caching). I would want to learn more about the workload and requirements first. The decision on runtime behaviour has implications here.

### Storage

1. Access control on the translation server: the bucket is public. That's it, I was just lazy
1. Support for multiple endpoints (storing translation files at multiple locations) is not included.
1. File storage model needs some more thinking.
  1. What comes first? The files in the remote storage or the fallback filenames?
  1. If we go through the local files and download a remote version for every one of them, then we skip a [maybe important] case: adding a new remote file that doesn't have the fallback yet. If it is more important to have a fallback at all times, then this can trigger a notification. If it is more important to see the new string, and *not having the fallback is not critical*, then the remote files take priority.
  1. If the remote files come first, we can use `list_objects` instead of globing the local directory

### Misc

1. There's nothing that immediately sets the alrams on thread safety here, but the step with clearing the directory and downloading files looks to me like it could be a critical path, and I would research this part a little more. 
1. The configuration and dependency injection is done through `RemoteInternationalization::Setup`. Ideally I would bring configuration and DI that makes sense (i.e. Dry-Configurable, Dry-Container).
1. The tests I am supplying are more of an integration-style tests. With no time, and low amound of code overall, I see these tests as a better choice (together with a working example)
1. I am not mocking the requests to S3 in tests but rather rely on the locally running minio during the test run. In production I would bring something like `vcr` to record those responses and mock requests in CI runs
1. The gem is not published
