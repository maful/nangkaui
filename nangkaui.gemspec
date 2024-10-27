# frozen_string_literal: true

require_relative "lib/nangkaui/version"

Gem::Specification.new do |spec|
  spec.name = "nangkaui"
  spec.version = NangkaUI::VERSION
  spec.authors = ["Maful"]
  spec.email = ["me@maful.web.id"]
  spec.summary = "NangkaUI is a UI library for Ruby"
  spec.description = "NangkaUI is a component library that helps you build beautiful interfaces with minimal effort"
  spec.homepage = "https://github.com/maful/nangkaui"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.files = Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency("zeitwerk", "~> 2.7")
end
