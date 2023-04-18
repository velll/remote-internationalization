require 'i18n'

require 'remote-internationalization/version'
require 'remote-internationalization/proxy'
require 'remote-internationalization/setup'

class RemoteInternationalization
  class Error < StandardError; end

  include RemoteInternationalization::Proxy

  def initialize(fallback_path: 'spec/examples/local', client: nil)
    I18n.load_path += Dir["#{File.expand_path(fallback_path)}/*.yml"]
  end
end
