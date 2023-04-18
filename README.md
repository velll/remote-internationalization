# Remote Internationalization

A Ruby gem that builds on top of the i18n library
Supports fetching translation files via HTTP rather than just relying on local translation files

Falls back to local translation files when encountered network issues 

# Initializing


# Server Side Requirements

The server should provide an S3 compatible interface for downloading files.
Similarly to I18n, the _Remote Internationalization_ expects a `load_path` to be set. The gem will try to download all translation files from the server.

# Out of scope

