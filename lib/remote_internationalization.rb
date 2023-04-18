require 'i18n'

require 'remote-internationalization/version'
require 'remote-internationalization/proxy'

class RemoteInternationalization
  class Error < StandardError; end

  include RemoteInternationalization::Proxy

  def initialize(fallback_path: 'spec/examples', client: nil)
    I18n.load_path += Dir["#{File.expand_path('spec/examples')}/*.yml"]
  end
end
