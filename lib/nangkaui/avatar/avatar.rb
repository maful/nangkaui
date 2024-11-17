# frozen_string_literal: true

module NangkaUI
  class Avatar < Base
    include Phlex::DeferredRender

    style do
      base { "relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full" }
    end

    def initialize(**system_arguments)
      system_arguments[:data_controller] = "nangkaui--avatar"

      super
    end

    def view_template
      span(class: tw_merge(style, classes), **system_arguments) do
        if @image
          render(AvatarImage.new(**@image))
        end

        if @fallback
          render(AvatarFallback.new(**@fallback.first), &@fallback.second)
        end
      end
    end

    def image(**attrs)
      @image = attrs
    end

    def fallback(**attrs, &block)
      @fallback = [attrs, block]
    end
  end
end
