# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("nangkaui" => "NangkaUI")
loader.setup

module NangkaUI
end

loader.eager_load
