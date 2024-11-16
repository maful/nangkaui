# frozen_string_literal: true

require "zeitwerk"
require "phlex"
require "tailwind_merge"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("nangkaui" => "NangkaUI")
loader.collapse("#{__dir__}/nangkaui/{button,alert,badge,label,card,skeleton,tabs}")
loader.setup

module NangkaUI
  NAMESPACE = "nangkaui"
end

loader.eager_load
