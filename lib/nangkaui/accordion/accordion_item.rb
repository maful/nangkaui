# frozen_string_literal: true

module NangkaUI
  class AccordionItem < Base
    include Phlex::DeferredRender

    def initialize(**system_arguments)
      @value = system_arguments.delete(:value)

      super
    end

    def view_template
      div(class: tw_merge("border-b", classes), **system_arguments) do
        if @trigger
          render(AccordionHeader.new(**@trigger.first.merge(value: @value)), &@trigger.second)
        end

        if @content
          render(AccordionContent.new(**@content.first.merge(value: @value)), &@content.second)
        end
      end
    end

    def trigger(**attrs, &block)
      @trigger = [attrs, block]
    end

    def content(**attrs, &block)
      @content = [attrs, block]
    end
  end
end
