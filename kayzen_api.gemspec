# frozen_string_literal: true

require_relative "lib/kayzen_api/version"

Gem::Specification.new do |spec|
  spec.name = "kayzen_api"
  spec.version = KayzenApi::VERSION
  spec.authors = ["Jonathan Senior"]
  spec.email = ["jonosenior@gmail.com"]

  spec.summary = "Ruby client for the Kayzen API"
  spec.description = "Ruby client for the Kayzen API"
  spec.homepage = "https://github.com/LatanaTech/kayzen_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/LatanaTech/kayzen_api/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dry-configurable", "~> 1.1.0"
  spec.add_dependency "dry-struct", "~> 1.6"
  spec.add_dependency "dry-types", "~> 1.7"
  spec.add_dependency "typhoeus", "~> 1.4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "byebug", "~> 11.1"
  spec.add_development_dependency "webmock", "~> 3.19"
  spec.add_development_dependency "standard", "~> 1.31"
  spec.add_development_dependency "dotenv", "~> 3.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
