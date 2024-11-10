# frozen_string_literal: true

module NangkaUI
  class CardHeader < Base
    include Phlex::DeferredRender

    def view_template
      div(class: "flex flex-col space-y-1.5 p-6", **system_arguments) do
        if @title
          div(class: "text-2xl font-semibold leading-none tracking-tight", &@title)
        end

        if @description
          div(class: "text-sm text-muted-foreground", &@description)
        end
      end
    end

    def title(&content)
      @title = content
    end

    def description(&content)
      @description = content
    end
  end
end
