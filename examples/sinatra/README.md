# Remote Internationalization

An example sinatra app that uses the `RemoteInternationalization` gem
This example relies on running a minio server (`docker-compose` from the root of this repo)

## Starting up

Install dependencies
```bash
bundle
```

Start up the server
```bash
bundle exec ruby app.rb
```

## Simulating network outage

Start minio first.
- switch to the root of this repo
- run `docker compose up`

Start the up with minio already running. The page will include remote translations
```bash
bundle exec ruby app.rb
```

Stop minio container, and restart the app. Now you will see the local/fallback translations
