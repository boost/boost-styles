# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boost/styles/version'

Gem::Specification.new do |spec|
  spec.name          = 'boost-styles'
  spec.version       = Boost::Styles::VERSION
  spec.authors       = ['Boost']
  spec.email         = ['info@boost.co.nz']

  spec.summary       = 'Shared Boost styles configuration'
  spec.description   = 'Centralised gem for all Boost styles configuration (Rubocop, ESLint etc...)'
  spec.homepage      = 'https://github.com/boost/boost-styles'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/boost/boost-styles'
    spec.metadata['changelog_uri'] = 'https://github.com/boost/boost-styles/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rails', '~> 5.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'haml_lint', '~> 0.33'
  spec.add_dependency 'rubocop', '~> 0.77'
  spec.add_dependency 'rubocop-performance', '~> 1.5.1'
  spec.add_dependency 'rubocop-rspec', '~> 1.37'
  spec.add_dependency 'rubocop-rails', '~> 2.4.0'
end
