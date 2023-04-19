require 'i18n'
require 'logger'
require 'aws-sdk-s3'
require 'pry'

require 'remote-internationalization/version'
require 'remote-internationalization/proxy'
require 'remote-internationalization/logger'
require 'remote-internationalization/setup'
require 'remote-internationalization/locale_file'
require 'remote-internationalization/prepare_files'
require 'remote-internationalization/initialize'
require 'remote-internationalization/adapters/s3'

class RemoteInternationalization
  class Error < StandardError; end

  extend Proxy
end

RI = RemoteInternationalization
