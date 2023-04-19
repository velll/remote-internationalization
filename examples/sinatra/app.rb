# myapp.rb
require 'sinatra'
require 'remote_internationalization'

require_relative './initializers/locale'

get '/' do
  RI.with_locale(params['locale'] || RI.default_locale) do
    erb :index, locals: { current_locale: RI.locale }
  end
end

helpers do
  def t(...)
    RI.t(...)
  end
end
