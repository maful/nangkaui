# frozen_string_literal: true

module NangkaUI
  class Accordion < Base
    include Phlex::DeferredRender

    def initialize(**system_arguments)
      system_arguments["data-controller"] = "nangkaui--accordion"
      @items = []

      super
    end

    def view_template
      div(class: classes, **system_arguments) do
        @items.each do |item|
          render(AccordionItem.new(**item.first), &item.second)
        end
      end
    end

    def item(**attrs, &block)
      @items << [attrs, block]
    end
  end
end
