class RemoteInternationalization
  module Proxy
    def with_locale(...)
      I18n.with_locale(...)
    end

    def t(...)
      I18n.t(...)
    end
  end
end
