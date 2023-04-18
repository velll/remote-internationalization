# Remote Internationalization

A Ruby gem that builds on top of the i18n library
Supports fetching translation files via HTTP rather than just relying on local translation files

Falls back to local translation files when encountered network issues 

# Initializing


# Server Side Requirements

The server should provide an S3 compatible interface for downloading files.
Similarly to I18n, the _Remote Internationalization_ expects a `load_path` to be set. The gem will try to download all translation files from the server.

# Out of scope

1. Access control on the transaltion server: the bucket is public
1. Updating translation during runtime: the translation files are downloaded and read once during initializing
1. Proxying method calls to I18n: only `I18n.with_locale` and `I18n.t` are supported
