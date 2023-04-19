lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'remote-internationalization/version'

Gem::Specification.new do |spec|
  spec.name          = 'remote-internationalization'
  spec.version       = RemoteInternationalization::VERSION
  spec.authors       = ['Paul Grachev']
  spec.email         = ['paul@paulgoesdeep.com']

  spec.summary       = 'Support remote transaltions by wrapping around i18n'
  spec.description   = ''
  spec.homepage      = 'https://github.com/velll/remote-internationalization'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 3.1.4'
  spec.add_dependency 'aws-sdk-s3'
  spec.add_dependency 'i18n'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop'
end
