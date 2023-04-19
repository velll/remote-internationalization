# myapp.rb
require 'sinatra'
require 'remote_internationalization'

require_relative './initializers/locale'

puts "hello : #{RemoteInternationalization.t(:hello)}"

RemoteInternationalization.with_locale(:de) do
  puts 'DE:'
  puts "hello : #{RemoteInternationalization.t(:hello)}"
end

get '/:locale?' do
  RemoteInternationalization.with_locale(params['locale'] || RemoteInternationalization.default_locale) do
    erb :index, locals: { current_locale: RemoteInternationalization.locale }
  end
end

helpers do
  def t(...)
    RemoteInternationalization.t(...)
  end
end
