# frozen_string_literal: true

require "zeitwerk"
require "phlex"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("nangkaui" => "NangkaUI")
loader.collapse("#{__dir__}/nangkaui/{button,alert,badge,label,card}")
loader.setup

module NangkaUI
  extend Phlex::Kit
end

loader.eager_load
