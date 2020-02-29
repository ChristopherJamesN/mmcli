# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mmcli/version'

Gem::Specification.new do |spec|
  spec.name          = 'mmcli'
  spec.version       = Mmcli::VERSION
  spec.authors       = ['ChristopherJamesN']
  spec.email         = ['nady.christopher@gmail.com']

  spec.summary       = 'A Ruby gem to manage manifest files from the command line.'
  spec.description   = 'A Ruby gem to manage manifest files from the command line.'
  spec.homepage      = 'https://github.com/ChristopherJamesN/mmcli'
  spec.license       = 'MIT'

  spec.files         = ['lib/mmcli.rb', 'lib/mmcli/cli/application.rb', 'lib/mmcli/version.rb']
  spec.executables << 'mmcli'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'thor', '~> 0.18'
end
