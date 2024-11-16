# frozen_string_literal: true

module NangkaUI
  class Tabs < TabsBase
    include Phlex::DeferredRender

    def initialize(**system_arguments)
      default_value = system_arguments.delete(:default_value)
      system_arguments["data-nangkaui--tabs-default-value-value"] = default_value
      @contents = []

      super
    end

    def view_template
      div(class: classes, **system_arguments) do
        if @tab_list
          render(TabsList.new(**@tab_list.first), &@tab_list.second)
        end

        @contents.each do |content|
          render(TabsContent.new(**content.first), &content.second)
        end
      end
    end

    def list(**attrs, &content)
      @tab_list = [attrs, content]
    end

    def content(**attrs, &content)
      @contents << [attrs, content]
    end
  end
end
