require 'i18n'
require 'logger'


require 'remote-internationalization/version'
require 'remote-internationalization/proxy'
require 'remote-internationalization/logger'
require 'remote-internationalization/setup'
require 'remote-internationalization/initialize'


class RemoteInternationalization
  class Error < StandardError; end

  extend Proxy
end
