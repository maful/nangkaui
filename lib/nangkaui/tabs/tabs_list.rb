# frozen_string_literal: true

module NangkaUI
  class TabsList < TabsBase
    include Phlex::DeferredRender

    style do
      base { "inline-flex h-10 items-center justify-center rounded-md bg-muted p-1 text-muted-foreground" }
    end

    def initialize(**system_arguments)
      @triggers = []

      super
    end

    def view_template(&content)
      div(class: tw_merge(style, classes), **system_arguments) do
        if @triggers.any?
          @triggers.each do |trigger|
            render(TabsTrigger.new(**trigger.first), &trigger.second)
          end
        end
      end
    end

    def trigger(**attrs, &content)
      @triggers << [attrs, content]
    end
  end
end
