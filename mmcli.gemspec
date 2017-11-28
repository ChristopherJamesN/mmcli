
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mmcli/version"

Gem::Specification.new do |spec|
  spec.name          = "mmcli"
  spec.version       = Mmcli::VERSION
  spec.authors       = ["ChristopherJamesN"]
  spec.email         = ["nady.christopher@gmail.com"]

  spec.summary       = %q{A Ruby gem to manage manifest files from the command line.}
  spec.description   = %q{A Ruby gem to manage manifest files from the command line.}
  spec.homepage      = "https://github.com/ChristopherJamesN/mmcli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency 'thor', '~> 0.18'
end
