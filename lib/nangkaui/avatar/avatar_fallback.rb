# frozen_string_literal: true

module NangkaUI
  class AvatarFallback < Base
    style do
      base { "flex h-full w-full items-center justify-center rounded-full bg-muted" }
    end

    def initialize(**system_arguments)
      system_arguments["data-nangkaui--avatar-target"] = "fallback"

      super
    end

    def view_template(&block)
      span(class: tw_merge(style, classes), **system_arguments, &block)
    end
  end
end
