# frozen_string_literal: true

module NangkaUI
  class AvatarImage < Base
    style do
      base { "aspect-square h-full w-full" }
    end

    def initialize(**system_arguments)
      source = system_arguments.delete(:src)
      system_arguments["data-nangkaui--avatar-target"] = "image"
      system_arguments["data-source"] = source

      super
    end

    def view_template
      img(class: tw_merge(style, classes), **system_arguments)
    end
  end
end
