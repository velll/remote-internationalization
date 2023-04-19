class RemoteInternationalization
  module Proxy
    def with_locale(...)
      I18n.with_locale(...)
    end

    def t(...)
      I18n.t(...)
    end

    def locale
      I18n.locale
    end

    def default_locale
      I18n.default_locale
    end
  end
end
